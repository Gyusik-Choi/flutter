import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieAPI {
  String url = 'https://imdb-api.com/en/API/BoxOffice/';
  String key = dotenv.get('KEY');

  Future<void> getMovies() async {
    http.Response response = await http.get(Uri.parse(url + key));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody);
  }
}