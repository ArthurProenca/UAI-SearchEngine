package dev.friday.com.uai.service;


import co.elastic.clients.elasticsearch.ElasticsearchClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
@Service
@RequiredArgsConstructor
@Slf4j
public class SearchRestService {

    private final ElasticsearchClient elasticsearchClient;

    public void search(String query, Integer page) {
        log.info("SearchRestService.search");

    }
}
