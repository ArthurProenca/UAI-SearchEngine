package dev.friday.com.uai.domain.search.som;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SearchOnMathResultItems {
    private String title;
    private String url;
    private String abst;
}
