import 'dart:convert';

class Registro {
  int? id;
  late int ownerId;
  String? text;
  late EMOTION_TYPE emotionType;
  late WEATHER_TYPE weatherType;
  late DateTime dataHoraCriacao;
  List<String>? tags;

  Registro({
    this.id,
    required this.ownerId,
    this.text,
    required this.emotionType,
    required this.weatherType,
    required this.dataHoraCriacao,
    this.tags,
  });

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
      id: json['id'],
      ownerId: json['ownerId'],
      text: json['text'],
      emotionType: EMOTION_TYPE.values.firstWhere((e) => e.toString() == 'EMOTION_TYPE.${json['emotionType']}'),
      weatherType: WEATHER_TYPE.values.firstWhere((e) => e.toString() == 'WEATHER_TYPE.${json['weatherType']}'),
      dataHoraCriacao: DateTime.parse(json['dataHoraCriacao']),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  static List<Registro> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Registro.fromJson(json)).toList();
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
  ANIMACAO
}

enum WEATHER_TYPE {
  ENSOLARADO,
  CHUVOSO,
  NUBLADO,
  TEMPESTUOSO,
  FRIO,
  LIMPO,
}
