package dev.friday.com.uai.service.search;


import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.MatchPhraseQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.MatchQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.Query;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Highlight;
import co.elastic.clients.elasticsearch.core.search.Hit;
import com.elasticsearch.search.api.model.Result;
import com.fasterxml.jackson.databind.node.ObjectNode;
import dev.friday.com.uai.client.es.EsClient;
import dev.friday.com.uai.domain.search.SearchContentDTO;
import dev.friday.com.uai.domain.search.SearchResultDTO;
import dev.friday.com.uai.domain.search.som.SearchOnMathResultDTO;
import dev.friday.com.uai.service.search.helper.SearchRestServiceHelper;
import dev.friday.com.uai.service.search.som.SearchOnMathRestService;
import dev.friday.com.uai.utils.PaginatedResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class SearchRestService {

    private final EsClient esClient;

    private final SearchOnMathRestService searchOnMathRestService;

    public SearchResultDTO search(String query, Integer page) {
        log.info("Query: {}", query);

        ElasticsearchClient elasticsearchClient = esClient.getConfiguredElasticSearchClient();

        List<Result> results = searchPerform(elasticsearchClient, query);

        List<SearchContentDTO> searchContentDTOS = results
                .stream()
                .map(
                        r -> new SearchContentDTO(r.getAbs(), r.getTitle(), r.getUrl())
                ).toList();

        PaginatedResult<SearchContentDTO> paginatedResult = new PaginatedResult<>(
                SearchRestServiceHelper.getPageItems(searchContentDTOS, page), page, searchContentDTOS.size());

        if (paginatedResult.getCurrentPage() > paginatedResult.getTotalPages()) {
            throw new RuntimeException("Page not found");
        }
        SearchOnMathResultDTO searchOnMathResultDTO;
        try {
            searchOnMathResultDTO = searchOnMathRestService.search(query);
        } catch (Exception e) {
            log.error("Error on search on math", e);
            searchOnMathResultDTO = SearchOnMathResultDTO.builder().result(new ArrayList<>()).totalResults(400L).build();
        }


        boolean hasSearchOnMathResults = !searchOnMathResultDTO.getResult().isEmpty() &&
                searchOnMathResultDTO.getTotalResults() != 400;

        return SearchResultDTO.builder()
                .wikipediaResults(paginatedResult.getItems())
                .hasWikipedia(true)
                .hasSearchOnMath(hasSearchOnMathResults)
                .searchOnMathResults(hasSearchOnMathResults ? searchOnMathResultDTO.getResult() : new ArrayList<>())
                .totalResults(paginatedResult.getTotalPages())
                .currentPage(paginatedResult.getCurrentPage())
                .build();

    }

    private List<Result> searchPerform(ElasticsearchClient elasticsearchClient, String query) {
        SearchResponse<ObjectNode> searchResponse = getSearchResponse(elasticsearchClient, query);

        List<Hit<ObjectNode>> hits = searchResponse.hits().hits();

        return hits
                .stream()
                .map(
                        h ->
                        {
                            assert h.source() != null;
                            return new Result()
                                    .abs(treatContent(h.highlight().get("content").get(0)))
                                    .title(h.source().get("title").asText())
                                    .url(h.source().get("url").asText());
                        }
                ).collect(Collectors.toList());
    }

    private SearchResponse<ObjectNode> getSearchResponse(ElasticsearchClient elasticsearchClient, String query) {
        Highlight highlight = SearchRestServiceHelper.getHighlight();

        Map<String, String> queryModifiers = getModifierQueryFromQuery(query);

        List<Query> mustQueries = new ArrayList<>();
        List<Query> shouldQueries = new ArrayList<>();

        mustQueries.add(MatchQuery.of(
                        q -> q.field("content").query(query))
                ._toQuery());


        for (String modifier : queryModifiers.keySet()) {
            switch (modifier) {
                case "must" -> mustQueries.add(MatchQuery.of(
                                q -> q.field("content").query(queryModifiers.get(modifier)))
                        ._toQuery());
                case "should" -> shouldQueries.add(MatchPhraseQuery.of(
                                q -> q.field("content").query(queryModifiers.get(modifier)))
                        ._toQuery());
            }
        }

        Query boolQuery = BoolQuery.of(b -> {
            if (!mustQueries.isEmpty()) {
                b.must(mustQueries);
            }
            if (!shouldQueries.isEmpty()) {
                b.should(shouldQueries);
            }
            if (!shouldQueries.isEmpty()) {
                b.minimumShouldMatch("1");
            }
            return b;
        })._toQuery();

        try {
            return elasticsearchClient.search(s -> s
                            .index("wikipedia")
                            .query(boolQuery)
                            .highlight(highlight),
                    ObjectNode.class
            );
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    private Map<String, String> getModifierQueryFromQuery(String query) {
        String[] parts = query.split("\\s*--\\s*");

        Map<String, String> modifiers = new HashMap<>();

        modifiers.put("query", parts[0]);

        for (String part : parts) {
            if (part.contains("must")) {
                modifiers.put("must", part.split("\\s+")[1]);
            }
            if (part.contains("should")) {
                modifiers.put("should", part.split("\\s+")[1]);
            }
        }

        return modifiers;
    }

    private static String treatContent(String content) {
        content = content.replaceAll("</?(som|math)\\d*>", " ");
        content = content.replaceAll("[^A-Za-z\\s</>]+", " ");
        content = content.replaceAll("\\s+", " ");
        content = content.replaceAll("^\\s+", "");
        return content;
    }
}
