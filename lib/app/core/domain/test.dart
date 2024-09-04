class Test {
  int? id;
  String title;
  String text;
  String bannerUrl;
  String questions;

  Test(
      {this.id,
      required this.title,
      required this.text,
      required this.bannerUrl,
      required this.questions});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'bannerUrl': bannerUrl,
      'questions': questions
    };
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        bannerUrl: json['bannerUrl'],
        questions: json['questions']);
  }

  static List<Test> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Test.fromJson(json)).toList();
  }



}
