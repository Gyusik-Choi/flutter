import 'package:get/get.dart';
import '../data/current_time.dart';
import '../data/current_weather.dart';
import '../models/weather_data.dart';

class DataController extends GetxController {

  final RxString time = ''.obs;
  // final Weather _weather = Rx(Weather) as Weather;
  // Weather 자료형을 obs로 받는법을 아직 파악 못해서 List로 형변환해서 리턴 받았다
  // => current_weather 페이지 참고
  // 아래의 코드를 보고 위의 아이디어를 얻음
  // https://github.com/kauemurakami/getx_pattern/blob/master/exemples/getx_pattern_example/lib/app/data/provider/api.dart
  final RxList weather = <Weather>[].obs;
  
  CurrentTime currentTime = CurrentTime();
  CurrentWeather currentWeather = CurrentWeather();

  @override
  Future<void> onInit() async {
    super.onInit();
    await callTime();
    await callWeather();
  }

  Future<void> callTime() async {
    var timeData = await currentTime.getTime();
    // https://unsungit.tistory.com/67
    // .value 를 붙여야하는걸 한참 구글링해서 알았다
    time.value = timeData;
  }

  Future<void> callWeather() async {
    var weatherData = await currentWeather.getWeather();
    weather.value = weatherData;
  }

}
