import 'dart:convert';

class Registro {
  int? id;
  int? ownerId;
  String? text;
  List<Comment>? comments;
  EMOTION_TYPE? emotionType;
  WEATHER_TYPE? weatherType;
  DateTime? dataHoraCriacao;
  List<String>? tags;

  Registro({
    this.id,
    this.ownerId,
    this.text,
    this.emotionType,
    this.weatherType,
    this.dataHoraCriacao,
    this.tags,
    this.comments,
  });

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
      id: json['id'],
      ownerId: json['ownerId'],
      text: json['text'],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      emotionType: json['emotionType'] != null
          ? EMOTION_TYPE.values.firstWhere(
              (e) => e.toString() == 'EMOTION_TYPE.${json['emotionType']}',
          orElse: () => EMOTION_TYPE.FELICIDADE)
          : null,
      weatherType: json['weatherType'] != null
          ? WEATHER_TYPE.values.firstWhere(
              (e) => e.toString() == 'WEATHER_TYPE.${json['weatherType']}',
          orElse: () => WEATHER_TYPE.ENSOLARADO)
          : null,
      dataHoraCriacao: json['dataHoraCriacao'] != null
          ? DateTime.parse(json['dataHoraCriacao'])
          : null,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'text': text,
      'comments': comments?.map((e) => e.toJson()).toList(),
      'emotionType': emotionType?.toString().split('.').last,
      'weatherType': weatherType?.toString().split('.').last,
      'dataHoraCriacao': dataHoraCriacao?.toIso8601String(),
      'tags': tags,
    };
  }

  static Registro fromUtf8Json(String jsonString) {
    final decodedBytes = utf8.decode(jsonString.codeUnits);
    final Map<String, dynamic> jsonData = json.decode(decodedBytes);
    return Registro.fromJson(jsonData);
  }

  static List<Registro> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Registro.fromJson(json as Map<String, dynamic>)).toList();
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
  FELICIDADE,
  ANSIEDADE,
  TEDIO,
  TRISTEZA,
  CONFUSAO,
  DECEPCAO,
  FOCO,
  APATICO,
  SURPRESA,
  CANSASO,
  MOTIVADO,
  ANIMACAO,
}

enum WEATHER_TYPE {
  ENSOLARADO,
  CHUVOSO,
  NUBLADO,
  TEMPESTUOSO,
  FRIO,
  LIMPO,
}
