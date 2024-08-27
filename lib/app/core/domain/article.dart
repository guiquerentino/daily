class Article {
  String title;
  String text;
  String autor;
  String bannerURL;
  DateTime creationDate;

  Article({
    required this.title,
    required this.text,
    required this.autor,
    required this.bannerURL,
    required this.creationDate,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        text: json['text'],
        autor: json['autor'],
        bannerURL: json['bannerURL'],
        creationDate: DateTime.parse(json['creationDate']));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'autor': autor,
      'bannerURL': bannerURL,
      'creationDate': creationDate
    };
  }

  static List<Article> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Article.fromJson(json)).toList();
  }
}
