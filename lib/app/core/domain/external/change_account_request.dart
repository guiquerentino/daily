import 'dart:typed_data';

class ChangeAccountRequest {
  int userId;
  String fullName;
  String email;
  int gender;
  Uint8List? profilePhoto;

  ChangeAccountRequest(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.gender,
      this.profilePhoto});

  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'email': email,
      'gender': gender,
      'profilePhoto': profilePhoto,
      'role': 0
    };
  }
}
