package dev.friday.com.uai.domain.search;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class SearchContentDTO {
    private String title;
    private String abs;

    private String url;

}
