package dev.friday.com.uai.controller;

import dev.friday.com.uai.service.SearchRestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@CrossOrigin
@RestController
@RequiredArgsConstructor
public class SearchRestController {

    private final SearchRestService searchRestService;

    public CompletableFuture<ResponseEntity<List<?>>> search(String query, Integer page) {
        return null;
    }
}
