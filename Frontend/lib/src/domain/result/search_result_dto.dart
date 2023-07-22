import 'package:flutter/material.dart';
import 'package:uai/src/domain/result/search_result_itens_dto.dart';

class SearchResultDTO {
  final List<SearchResultItensDTO> wikipediaResults;
  final List<SearchResultItensDTO> searchOnMathResults;
  final bool hasSearchOnMath;
  final bool hasWikipedia;
  final int currentPage;
  final int totalPages;

  const SearchResultDTO(
      this.wikipediaResults,
      this.searchOnMathResults,
      this.hasSearchOnMath,
      this.hasWikipedia,
      this.currentPage,
      this.totalPages);

  factory SearchResultDTO.fromJson(Map<String, dynamic> json) {
    debugPrint(json['searchOnMathResults'].toString());
    if (json['wikipediaResults'] == null ||
        json['searchOnMathResults'] == null ||
        json['wikipediaResults'] == [] ||
        json['searchOnMathResults'] == []) {
      throw Exception('Erro ao buscar resultados');
    }
    final wikipediaResults = json['wikipediaResults'] as List;
    final searchOnMathResults = json['searchOnMathResults'] as List;

    final wikipediaResultsList =
        wikipediaResults.map((e) => SearchResultItensDTO.fromJson(e)).toList();

    final searchOnMathResultsList = searchOnMathResults
        .map((e) => SearchResultItensDTO.fromJson(e))
        .toList();
    final int currentPage = json['currentPage'];
    final int totalPages = json['totalPages'];
    return SearchResultDTO(wikipediaResultsList, searchOnMathResultsList,
        json['hasSearchOnMath'], json['hasWikipedia'], currentPage, totalPages);
  }
}
