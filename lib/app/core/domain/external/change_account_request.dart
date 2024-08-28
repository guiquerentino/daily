class ChangeAccountRequest {
  int userId;
  String fullName;
  String email;
  int gender;

  ChangeAccountRequest(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.gender});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'gender': gender
    };
  }
}
