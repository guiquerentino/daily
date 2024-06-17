import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../core/domain/article.dart';

class ArticlesService {

  Future<List<Article>> fetchLastArticles() async {
    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/article'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final List<dynamic> decodedJson = jsonDecode(response.body);

    return Article.fromJsonList(decodedJson);
  }

}

