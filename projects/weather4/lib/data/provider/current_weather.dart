import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrentWeather {
  final String apiKey = "e6c470c2409597906887a8c6fbb08840";

  Future<Map<String, dynamic>> getWeather(double lat, double long) async {
    // lang=kr 설정하면 description 부분을 한글로 볼 수 있다
    http.Response response = await http.post(Uri.parse("https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$long&appid=$apiKey"));
    Map<String, dynamic> responseBody = await json.decode(response.body);
    return responseBody;
  }
}