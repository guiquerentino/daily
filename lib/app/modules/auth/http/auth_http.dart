import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/account_request.dart';


class AuthHttp {
  Future<http.Response> createAccount(AccountRequest request) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<http.Response> authorizeAccount(AccountRequest request) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/account/authorize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<http.Response> changePassword(AccountRequest request) {
    return http.put(
      Uri.parse('http://10.0.2.2:8080/api/v1/account/password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }

  Future<AccountRequest?> isLogged() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    return AccountRequest(accountType: 1, email: email, password: password);
  }
}
