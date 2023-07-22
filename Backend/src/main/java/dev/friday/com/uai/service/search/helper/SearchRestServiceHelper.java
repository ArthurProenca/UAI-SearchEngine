package dev.friday.com.uai.service.search.helper;

import co.elastic.clients.elasticsearch.core.search.Highlight;
import co.elastic.clients.elasticsearch.core.search.HighlightField;
import co.elastic.clients.elasticsearch.core.search.HighlighterType;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class SearchRestServiceHelper {

    public static Highlight getHighlight() {
        return Highlight.of(
                h -> h.type(HighlighterType.Unified)
                        .fields(getHighlightFieldMap())
        );
    }

    private static Map<String, HighlightField> getHighlightFieldMap() {
        Map<String, HighlightField> map = new HashMap<>();
        map.put("content", HighlightField.of(hf -> hf.numberOfFragments(1).fragmentSize(300)));
        Highlight highlight = Highlight.of(
                h -> h.type(HighlighterType.Unified)
                        .fields(map)
        );

        return map;
    }

    // Método utilitário para obter os itens da página atual
    public static <T> List<T> getPageItems(List<T> allItems, int currentPage) {
        int startIndex = (currentPage - 1) * 5;
        int endIndex = Math.min(startIndex + 5, allItems.size());
        return allItems.subList(startIndex, endIndex);
    }
}
