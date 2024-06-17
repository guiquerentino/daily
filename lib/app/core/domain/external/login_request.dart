class LoginRequest {
  String email;
  String password;
  int accountType;
  LoginRequest({required this.email, required this.password, required this.accountType});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'accountType': accountType};
  }
}
