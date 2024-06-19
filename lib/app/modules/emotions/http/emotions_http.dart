import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../core/domain/emotion.dart';


class EmotionsHttp {

  Future<List<Emotion>> fetchRegister(int? ownerId, DateTime dataHora) async {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dataHora);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/emotions/user/$ownerId?date=$formattedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = jsonDecode(responseBody);
      return Emotion.fromJsonList(jsonList);
    } else {
      throw Exception('Failed to load registros');
    }
  }

  Future<void> saveRegister(Emotion request) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/emotions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson())
    );
  }
}
