package dev.friday.com.uai.domain.search;

import dev.friday.com.uai.domain.search.som.SearchOnMathResultDTO;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SearchResultDTO {
    private List<SearchContentDTO> wikipediaResults;
    private SearchOnMathResultDTO searchOnMathResults;
    private boolean hasSearchOnMath;
    private boolean hasWikipedia;

}
