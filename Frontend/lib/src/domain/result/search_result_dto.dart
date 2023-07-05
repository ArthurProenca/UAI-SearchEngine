class SearchResultDTO {
  final String title;
  final String abs;
  final String url;
  final bool isUAI;

  const SearchResultDTO(this.title, this.abs, this.url, this.isUAI);

  factory SearchResultDTO.fromJson(Map<String, dynamic> json) {
    return SearchResultDTO(json['title'], json['abs'], json['url'], true);
  }
}
