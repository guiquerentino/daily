class Article {
  String title;
  String text;
  String autor;
  String creationDate;

  Article({
    required this.title,
    required this.text,
    required this.autor,
    required this.creationDate,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        text: json['text'],
        autor: json['autor'],
        creationDate: json['creationDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'autor': autor,
      'creationDate': creationDate
    };
  }

  static List<Article> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Article.fromJson(json)).toList();
  }
}
