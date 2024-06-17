import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../core/domain/tags.dart';

class TagsHttp {
  Future<List<Tags>> fetchTags() async {

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/emotions/tags'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = jsonDecode(responseBody);
      return Tags.fromJsonList(jsonList);
    } else {
      throw Exception('Failed to load tags');
    }
  }
}
