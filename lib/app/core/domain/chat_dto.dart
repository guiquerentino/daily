import 'dart:typed_data';

class ChatDTO {
  final int? id;
  final PsychologistDto? psychologist;
  final String? lastMessage;
  final String? lastMessageTime;

  ChatDTO({
    this.id,
    this.psychologist,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    return ChatDTO(
      id: json['id'],
      psychologist: json['psychologist'] != null
          ? PsychologistDto.fromJson(json['psychologist'])
          : null,
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'psychologist': psychologist?.toJson(),
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }

  static List<ChatDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ChatDTO.fromJson(json)).toList();
  }
}

class PsychologistDto {
  final int id;
  final String? name;
  final String? gender;
  final int? age;
  final Uint8List? profilePhoto;

  PsychologistDto({
    required this.id,
    this.name,
    this.gender,
    this.age,
    this.profilePhoto,
  });

  factory PsychologistDto.fromJson(Map<String, dynamic> json) {
    return PsychologistDto(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      profilePhoto: json['profilePhoto'] != null
          ? Uint8List.fromList(List<int>.from(json['profilePhoto']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'profilePhoto': profilePhoto,
    };
  }

  static List<PsychologistDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PsychologistDto.fromJson(json)).toList();
  }
}
