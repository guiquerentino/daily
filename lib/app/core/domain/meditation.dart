class Meditation {
  int? id;
  String name;
  String photoUrl;
  String type;
  String text;
  String audioFile;
  String duration;

  Meditation(
      {this.id,
      required this.name,
      required this.photoUrl,
      required this.type,
      required this.text,
      required this.duration,
      required this.audioFile});

  factory Meditation.fromJson(Map<String, dynamic> json) {
    return Meditation(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      type: json['type'],
      text: json['text'],
      duration: json['duration'],
      audioFile: json['audioFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'type': type,
      'text': text,
      'duration': duration,
      'audioFile': audioFile
    };
  }
}
