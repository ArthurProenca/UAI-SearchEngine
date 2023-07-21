package dev.friday.com.uai.domain.search;

import dev.friday.com.uai.domain.search.som.SearchOnMathResultDTO;
import dev.friday.com.uai.utils.PaginatedResult;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SearchResultDTO {
    private PaginatedResult<SearchContentDTO> wikipediaResults;
    private SearchOnMathResultDTO searchOnMathResults;
    private boolean hasSearchOnMath;
    private boolean hasWikipedia;

}
