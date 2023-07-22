class SearchResultItensDTO {
  final String message;
  final String title;
  final String uri;

  const SearchResultItensDTO(this.message, this.title, this.uri);

  factory SearchResultItensDTO.fromJson(Map<String, dynamic> json) {
    return SearchResultItensDTO(json['abs'], json['title'], json['url']);
  }
}
