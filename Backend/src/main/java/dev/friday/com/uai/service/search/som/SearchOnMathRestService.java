package dev.friday.com.uai.service.search.som;

import dev.friday.com.uai.client.som.SearchOnMathClient;
import dev.friday.com.uai.domain.search.som.SearchOnMathResultDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class SearchOnMathRestService {

    private final SearchOnMathClient searchOnMathClient;

    public SearchOnMathResultDTO search(String query) {
        log.info("Query: {}", query);
        return searchOnMathClient.searchByQuery(query, 0);
    }
}
