class Article {
  String title;
  String text;
  String autor;
  String bannerURL;
  DateTime creationDate;
  String minutesToRead;
  String category;

  Article({
    required this.title,
    required this.text,
    required this.autor,
    required this.bannerURL,
    required this.creationDate,
    required this.minutesToRead,
    required this.category
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        text: json['text'],
        autor: json['autor'],
        category: json['category'],
        minutesToRead: json['minutesToRead'],
        bannerURL: json['bannerURL'],
        creationDate: DateTime.parse(json['createdAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'autor': autor,
      'category':category,
      'minutesToRead': minutesToRead,
      'bannerURL': bannerURL,
      'createdAt': creationDate
    };
  }

  static List<Article> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Article.fromJson(json)).toList();
  }
}
