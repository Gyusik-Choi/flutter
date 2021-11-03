import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_controller.dart';

class Weather extends StatelessWidget {
  Weather({Key? key}) : super(key: key);

  final DataController _d = Get.put(DataController());
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Obx(() { 
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: _d.weather.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : weatherView(height),
        ),
      );
    });
  }

  Widget weatherView(double height) {
    int idx = 0;
    int id = _d.weather[0].id;

    if (id < 300) {
      idx = 0;
    } else if (id < 600) {
      idx = 1;
    } else if (id < 700) {
      idx = 2;
    } else if (id < 800) {
      idx = 3;
    } else if (id == 800) {
      idx = 4;
    } else {
      idx = 3;
    }

    List<String> weatherIcons = ["flash", "drop", "snow", "cloud", "sunny"];
    String weatherIcon = weatherIcons[idx];

    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      // https://www.youtube.com/watch?v=apPH1CCOtKQ
      // https://github.com/afzalali15/shopx/blob/master/lib/views/homepage.dart
      // Obx 쓰면 그간
      // "you should only use getX or obx for the specific widget that will be updated."
      // 이런 에러를 받아서 Obx 를 쓰기가 망설여졌는데
      // 위의 유튜브 영상을 보고서 아이디어를 얻어서 시도해보았는데 됐다
      // => Obx 를 통해서 _d.time 이 나오지 않는 문제를 해결함
      // => _d.time 의 값이 ''에서 특정 시간으로 변화된 것을 Obx 를 통해서 감지하고 이를 화면에 반영할 수 있게 됐다
      child: Center(
        child: Column(
          children: <Widget> [
            Text(
              '${_d.time}',
              style: const TextStyle(
                color: Colors.white,
              )
            ),
            Text(
              '${_d.weather[0].cityName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01)
            ),
            Image.asset(
              'assets/images/$weatherIcon.png',
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                Text(
                  '${_d.weather[0].temperature} °C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),
                Text(
                  '${_d.weather[0].description}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ]
            ),
          ],
        )
      )
    );
  }

}