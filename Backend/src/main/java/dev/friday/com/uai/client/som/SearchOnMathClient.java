package dev.friday.com.uai.client.som;

import dev.friday.com.uai.domain.search.som.SearchOnMathResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "search-on-math", url = "${search-on-math.url}")
@Component
public interface SearchOnMathClient {

    @GetMapping("/webservice")
    SearchOnMathResultDTO searchByQuery(@RequestParam String query, @RequestParam Integer page);
}
