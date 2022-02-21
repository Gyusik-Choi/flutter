import 'package:get/get.dart';
import '../data/repository/api_repository.dart';

class ApiController extends GetxController{

  ApiRepository ar = ApiRepository();

  RxDouble latitude = 0.0.obs;
  RxDouble longtitude = 0.0.obs;
  RxInt weatherId = 0.obs;
  RxString weatherMain = ''.obs;
  RxString weatherDescription = ''.obs;
  RxString weatherIcon = ''.obs;
  RxInt weatherTemp = 0.obs;
  RxInt weatherTempMax = 0.obs;
  RxInt weatherTempMin = 0.obs;
  RxString weatherCity = ''.obs;

  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getLocation();
    await getWeather(latitude.toDouble(), longtitude.toDouble());
  }

  Future<void> getLocation() async {
    await ar.getLocation();
    var info = await ar.getLocation();
    latitude.value = info[0];
    longtitude.value = info[1];
  }

  Future<void> getWeather(double lat, double long) async {
    Map<String, dynamic> weatherInfo = await ar.getWeather(lat, long);

    weatherId.value = weatherInfo['weather'][0]['id'];
    weatherMain.value = weatherInfo['weather'][0]['main'];
    weatherDescription.value = weatherInfo['weather'][0]['description'];
    weatherIcon.value = weatherInfo['weather'][0]['icon'];
    weatherTemp.value = (weatherInfo['main']['temp']).toInt();
    weatherTempMax.value = (weatherInfo['main']['temp_max']).toInt();
    weatherTempMin.value = (weatherInfo['main']['temp_min']).toInt();
    weatherCity.value = weatherInfo['name'];
    
    isLoading.value = false;
  }
}