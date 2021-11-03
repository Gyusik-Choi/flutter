import 'dart:convert';
import 'package:http/http.dart' as http;
import './current_location.dart';
import '../models/weather_data.dart';

// 함수명 앞에 _ 붙이면 외부에서 접근이 불가능하다.
// Future<void> _getWeather() async {
class CurrentWeather {
  // Future<Weather> getWeather() async {
  Future<List<Weather>> getWeather() async {
    String apiKey = "e6c470c2409597906887a8c6fbb08840";
    double _lat;
    double _long;

    List<double> _latAndLong = await getLocation();
    _lat = _latAndLong[0];
    _long = _latAndLong[1];

    http.Response response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=$_lat&lon=$_long&appid=$apiKey'));
    Map<String, dynamic> responseBody = await json.decode(response.body);
    Weather weatherInfo = Weather.fromJson(responseBody);

    // Weather 자료형을 obs로 받는법을 아직 파악 못해서 List로 형변환해서 리턴했다
    List<Weather> weatherInformation = [weatherInfo];
    return weatherInformation;
  }
}
