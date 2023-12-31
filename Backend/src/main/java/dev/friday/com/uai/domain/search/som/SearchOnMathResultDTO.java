package dev.friday.com.uai.domain.search.som;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
public class SearchOnMathResultDTO {
    private Long totalResults;
    private List<SearchOnMathResultItems> result;
}
