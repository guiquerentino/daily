import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/CreateAccountRequest.dart';

class LoginService {
  Future<http.Response> createAccount(CreateAccountRequest request) {
    return http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/account'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );
  }
}
