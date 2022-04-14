import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieAPI {
  String key = 'k_8e9i8qvy';

  Future<void> getMovies() async {
    http.Response response = await http.get(Uri.parse('https://imdb-api.com/en/API/BoxOffice/k_8e9i8qvy'));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody);
  }
}