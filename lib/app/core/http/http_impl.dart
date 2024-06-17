import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpImpl {
  final String baseUrl;

  HttpImpl(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _processResponse(response);
  }

  Future<dynamic> _processResponse(http.Response response) async {
    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    } else {
      throw Exception('HTTP Error: $statusCode - ${responseBody['error']}');
    }
  }
}
