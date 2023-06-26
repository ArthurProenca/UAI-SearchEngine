package dev.friday.com.uai.controller;

import co.elastic.clients.elasticsearch.core.SearchResponse;
import com.fasterxml.jackson.databind.node.ObjectNode;
import dev.friday.com.uai.service.search.SearchRestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequiredArgsConstructor
public class SearchRestController {

    private final SearchRestService searchRestService;

    @GetMapping("/v1/search")
    public Object search(@RequestParam String query, @RequestParam Integer page) {
        return searchRestService.search(query, page);
    }
}
