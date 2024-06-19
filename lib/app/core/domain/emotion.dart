import 'dart:convert';

import 'package:daily/app/core/domain/tags.dart';

class Emotion {
  int? id;
  int? ownerId;
  String? text;
  List<Comment>? comments;
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
    this.comments,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(
      id: json['id'],
      ownerId: json['ownerId'],
      text: json['text'],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'comments': comments?.map((e) => e.toJson()).toList(),
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

class Comment {
  int? id;
  int? registerId;
  String? text;
  DateTime? dataHoraCriacao;

  Comment({
    this.id,
    this.registerId,
    this.text,
    this.dataHoraCriacao,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      registerId: json['registerId'],
      text: json['text'],
      dataHoraCriacao: json['dataHoraCriacao'] != null
          ? DateTime.parse(json['dataHoraCriacao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registerId': registerId,
      'text': text,
      'dataHoraCriacao': dataHoraCriacao?.toIso8601String(),
    };
  }
}

enum EMOTION_TYPE {
  BRAVO,
  TRISTE,
  FELIZ,
  NORMAL,
  MUITO_FELIZ,
}

