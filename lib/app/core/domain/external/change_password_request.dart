class ChangePasswordRequest {
  String email;
  String password;

  ChangePasswordRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'newPassword': password};
  }
}
