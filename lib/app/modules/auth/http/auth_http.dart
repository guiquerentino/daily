import 'dart:convert';
import 'package:daily/app/core/domain/external/change_password_request.dart';
import 'package:daily/app/core/domain/external/create_account_request.dart';
import 'package:daily/app/core/domain/external/login_request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/account.dart';


class AuthHttp {
  Future<http.Response> createAccount(CreateAccountRequest request) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<http.Response> authorizeAccount(LoginRequest request) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/account/authorize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<http.Response> changePassword(ChangePasswordRequest request) {
    return http.put(
      Uri.parse('http://10.0.2.2:8080/api/v1/account/password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<LoginRequest?> isLogged() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    return LoginRequest(accountType: 0, email: email, password: password);
  }
}
