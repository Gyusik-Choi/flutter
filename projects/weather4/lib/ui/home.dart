import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/api_controller.dart';

class Home extends StatelessWidget {

  Home({Key? key}) : super(key: key);

  final ApiController _controller = Get.put(ApiController());
  // 주의!
  // 아래처럼 수행하니 controller 쪽의 onInit이 호출되지 않았다
  // controller가 위젯과 연결되지 않아서 수행될 수 없었다
  // final ApiController _controller = ApiController();

  final Map<String, String> iconMap = {
    "01": "sun",
    "02": "cloud",
    "03": "cloud",
    "04": "cloud",
    "09": "drizzle",
    "10": "rain",
    "11": "thunderstorm",
    "13": "snow",
    "50": "mist",
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Obx 를 쓰려면 Obx 아래에 GetxController 의 프로퍼티가 존재해야 한다
    return Obx(() => SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pink,
        body: _controller.weatherMain.isEmpty ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : homeBody(width, height)
      )
    ));
  }

  Widget homeBody(double w, double h) {
    String iconValue = _controller.weatherIcon.toString();
    String? iconMapValue = iconMap[iconValue.substring(0, 2)];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Center(
          child: Text(
            _controller.weatherCity.toString(),
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: h * 0.01),
        ),
        Center(
          child: Text(
            _controller.weatherDescription.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ),
        Center(
          child: Image.asset(
            'assets/images/$iconMapValue.png',
            width: w * 0.3,
            height: h * 0.3,
          )
        ),
        Center(
          child: Text(
            _controller.weatherTemp.toString() + " º",
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            )
          )
        ),
        Center(
          child: Text(
            "최고 " + _controller.weatherTempMax.toString() + " / " + "최저 " + _controller.weatherTempMin.toString(),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
