import 'dart:convert';

import 'package:daily/app/core/domain/tags.dart';

class Emotion {
  int? id;
  int? ownerId;
  String? text;
  String? comment;
  EMOTION_TYPE? emotionType;
  DateTime? creationDate;
  List<Tags>? tags;

  Emotion({
    this.id,
    this.ownerId,
    this.text,
    this.emotionType,
    this.creationDate,
    this.tags,
    this.comment,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(
      id: json['id'],
      ownerId: json['ownerId'],
      text: json['text'],
      comment: json['comment'],
      emotionType: json['emotionType'] != null
          ? EMOTION_TYPE.values.firstWhere(
            (e) => e.toString() == 'EMOTION_TYPE.${json['emotionType']}',
        orElse: () => EMOTION_TYPE.FELIZ,
      )
          : null,
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tagJson) => Tags.fromJson(tagJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'text': text,
      'comment': comment,
      'emotionType': emotionType?.toString().split('.').last,
      'creationDate': creationDate?.toIso8601String(),
      'tags': tags?.map((e) => e.toJson()).toList(),
    };
  }


  static Emotion fromUtf8Json(String jsonString) {
    final decodedBytes = utf8.decode(jsonString.codeUnits);
    final Map<String, dynamic> jsonData = json.decode(decodedBytes);
    return Emotion.fromJson(jsonData);
  }

  static List<Emotion> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Emotion.fromJson(json as Map<String, dynamic>)).toList();
  }
}

enum EMOTION_TYPE {
  BRAVO,
  TRISTE,
  FELIZ,
  NORMAL,
  MUITO_FELIZ,
}

