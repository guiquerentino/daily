class Tags {
  int id;
  String emote;
  String text;

  Tags({required this.id, required this.emote, required this.text});

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(id: json['id'], emote: json['emote'], text: json['text']);
  }

  static List<Tags> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Tags.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'emote': emote, 'text': text};
  }
}
