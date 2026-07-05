class KbArticle {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String content;
  final int views;
  final int helpfulCount;

  KbArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.content,
    required this.views,
    required this.helpfulCount,
  });
}