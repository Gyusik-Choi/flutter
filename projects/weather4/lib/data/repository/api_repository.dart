import 'package:weather4/data/provider/current_weather.dart';

import '../provider/current_location.dart';
import '../provider/current_weather.dart';

class ApiRepository {
  final CurrentLocation cl = CurrentLocation();
  final CurrentWeather cw = CurrentWeather();

  getLocation() {
    return cl.getLocation();
  }

  getWeather(double lat, double long) {
    return cw.getWeather(lat, long);
  }
}