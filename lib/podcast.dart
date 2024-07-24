enum Category {
  devotion,
  doctrine,
}

class Podcast {
  String title;
  String? description;
  String audioUrl;
  Category category;

  Podcast({
    this.description,
    required this.audioUrl,
    required this.title,
    required this.category,
  });
}
