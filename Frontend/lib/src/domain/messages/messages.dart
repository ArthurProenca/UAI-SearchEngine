class Messages {
  final String message;
  final String uri;
  final bool isUser;
  final int currentPage;
  final int totalPages;
  final bool hasSearchOnMath;
  final bool hasWikipedia;

  const Messages(this.message, this.uri, this.isUser, this.currentPage,
      this.totalPages, this.hasSearchOnMath, this.hasWikipedia);
}
