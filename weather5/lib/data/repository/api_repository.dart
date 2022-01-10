import 'package:weather5/data/provider/current_weather.dart';

import '../provider/current_location.dart';
import '../provider/current_weather.dart';
import '../provider/image_provider.dart';

class ApiRepository {
  final CurrentLocation cl = CurrentLocation();
  final CurrentWeather cw = CurrentWeather();
  final ImageProvider imageProvider = ImageProvider();

  getLocation() {
    return cl.getLocation();
  }

  getWeather(double lat, double long) {
    return cw.getWeather(lat, long);
  }

  getTakenPhoto() {
    return imageProvider.takePhoto();
  }
}