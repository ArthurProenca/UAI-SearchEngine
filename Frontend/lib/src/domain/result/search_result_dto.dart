class SearchResultDTO {
  final String title;
  final String abs;
  final String url;

  const SearchResultDTO(this.title, this.abs, this.url);

  factory SearchResultDTO.fromJson(Map<String, dynamic> json) {
    return SearchResultDTO(json['title'], json['abs'], json['url']);
  }
}
