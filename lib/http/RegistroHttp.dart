import 'dart:convert';
import 'package:daily/entities/Registro.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegistroHttp {

  Future<List<Registro>> recuperarRegistros(int ownerId, DateTime dataHora) async {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dataHora);
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/register/user/$ownerId?dataHora=$formattedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return Registro.fromJsonList(jsonList);
    } else {
      throw Exception('Failed to load registros');
    }
  }
}