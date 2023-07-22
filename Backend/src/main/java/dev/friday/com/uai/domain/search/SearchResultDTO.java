package dev.friday.com.uai.domain.search;

import dev.friday.com.uai.domain.search.som.SearchOnMathResultItems;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SearchResultDTO {
    private List<SearchContentDTO> wikipediaResults;
    private List<SearchOnMathResultItems> searchOnMathResults;
    private boolean hasSearchOnMath;
    private boolean hasWikipedia;
    private int totalResults;
    private int currentPage;

}
