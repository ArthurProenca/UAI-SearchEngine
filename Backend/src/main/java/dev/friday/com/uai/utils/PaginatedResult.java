package dev.friday.com.uai.utils;

import java.util.List;

public class PaginatedResult<T> {
    private List<T> items;
    private int currentPage;
    private int totalPages;

    public PaginatedResult(List<T> items, int currentPage, int totalItems) {
        this.items = items;
        this.currentPage = currentPage;
        this.totalPages = (int) Math.ceil((double) totalItems / 5); // Limite fixo de 5 itens por página
    }

    public List<T> getItems() {
        return items;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    // Método para verificar se existe uma página anterior à atual
    public boolean hasPreviousPage() {
        return currentPage > 1;
    }

    // Método para verificar se existe uma próxima página após a atual
    public boolean hasNextPage() {
        return currentPage < totalPages;
    }
}


