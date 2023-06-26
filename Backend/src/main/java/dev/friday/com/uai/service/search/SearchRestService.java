package dev.friday.com.uai.service.search;


import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.query_dsl.MatchQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.Query;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Highlight;
import co.elastic.clients.elasticsearch.core.search.Hit;
import com.elasticsearch.search.api.model.Result;
import com.fasterxml.jackson.databind.node.ObjectNode;
import dev.friday.com.uai.client.es.EsClient;
import dev.friday.com.uai.service.search.helper.SearchRestServiceHelper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class SearchRestService {

    private final EsClient esClient;

    public List<Result> search(String query, Integer page) {
        log.info("Query: {}", query);

        ElasticsearchClient elasticsearchClient = esClient.getConfiguredElasticSearchClient();

        return searchPerform(elasticsearchClient, query);

    }

    private List<Result> searchPerform(ElasticsearchClient elasticsearchClient, String query) {
        SearchResponse<ObjectNode> searchResponse  = getSearchResponse(elasticsearchClient, query);

        List<Hit<ObjectNode>> hits = searchResponse.hits().hits();

        return  hits
                .stream()
                .map(
                        h ->
                                new Result()
                                        .abs(treatContent(h.highlight().get("content").get(0)))
                                        .title(h.source().get("title").asText())
                                        .url(h.source().get("url").asText())
                ).collect(Collectors.toList());
    }

    private SearchResponse<ObjectNode> getSearchResponse(ElasticsearchClient elasticsearchClient, String query) {
        Highlight highlight = SearchRestServiceHelper.getHighlight();

        Query matchQuery = MatchQuery.of(
                        q -> q.field("content").query(query))
                ._toQuery();

        try {
            return elasticsearchClient.search(s -> s
                    .index("wikipedia")
                    .query(matchQuery).highlight(highlight), ObjectNode.class
            );
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String treatContent(String content) {
        content = content.replaceAll("</?(som|math)\\d*>", " ");
        content = content.replaceAll("[^A-Za-z\\s</>]+", " ");
        content = content.replaceAll("\\s+", " ");
        content = content.replaceAll("^\\s+", "");
        return content;
    }
}
