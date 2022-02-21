import 'dart:io';
import 'package:get/get.dart';
import '../data/repository/api_repository.dart';
import '../data/repository/database_repository.dart';
import '../data/database/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController{

  ApiRepository ar = ApiRepository();
  DatabaseRepository dr = DatabaseRepository();

  final int maxImageSize = 3145086;

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

  // RxString pickedImageFromAlbum = ''.obs;

  RxBool isDefault = false.obs;
  RxList dbBackground = [].obs;
  RxList<dynamic> uint8ListImage = [].obs;

  // ignore: prefer_typing_uninitialized_variables
  // var db;
  // late List<Map<String, dynamic>> background;

  // ignore: prefer_typing_uninitialized_variables
  var prefs;
  late String imgPath;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getLocation();
    await getWeather(latitude.toDouble(), longtitude.toDouble());
    
    prefs = await SharedPreferences.getInstance();
    imgPath = prefs.getString('imgPath') ?? '';
    if (imgPath.isEmpty) {
      uint8ListImage.value = [0];
      isDefault.value = true;
    } else {
      uint8ListImage.value = [Utility.dataFromBase64String(imgPath)];
      isDefault.value = false;
    }

    // db = await dr.getDatabase();
    // https://stackoverflow.com/questions/54063329/flutter-sql-how-to-return-plain-values?rq=1
    // 쿼리문 결과는 List<Map<String, dynamic>> 형태로 리턴된다
    // try {
    //   background = await dr.getBackground();
    // } catch (err) {
    //   print(err);
    //   return;
    // }
    // print(background);

    // if (background.isEmpty) {
    //   uint8ListImage.value = [0];
    //   isDefault.value = true;
    // } else {
      // if (background.length > 1) {
      //   int tempDataFromBase64String = 0;
      //   for (int i = 0; i < background.length; i++) {
      //     tempDataFromBase64String += Utility.dataFromBase64String(background[i]["background"]) as int;
      //   }
      //   uint8ListImage.value = [tempDataFromBase64String];
      // } else {
      //   uint8ListImage.value = [Utility.dataFromBase64String(background[0]["background"])];
      // }
      // uint8ListImage.value = [Utility.dataFromBase64String(background[0]["background"])];
      // isDefault.value = false;
    // }
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

  Future<void> takePicture() async {
    File file = await ar.getTakenPhoto();

    String imgString = Utility.base64String(file.readAsBytesSync());
    prefs.setString('imgPath', imgString);
    
    uint8ListImage.value = [Utility.dataFromBase64String(prefs.getString('imgPath'))];
    isDefault.value = false;
    
    // String imgString = Utility.base64String(file.readAsBytesSync());

    // imgString 사이즈가 커서 DB에 잘라서 넣으려니 DB에 넣는건 문제가 없었으나
    // 꺼내서 base64String를 통해 base64Decode를 하려니 다음과 같은 에러 발생
    // [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: FormatException: Invalid length, must be multiple of four (at character 3145087)
    // decode 할 수 없는 형태의 문자열이어서 그런듯 하다
    // 통으로 이미지를 저장할 수 있는 방식으로 변경 필요

    // int fileLength = (await file.length()).toInt();
    // int divisionValue = 0;
    // if (fileLength > maxImageSize) {
    //   divisionValue = (fileLength / maxImageSize).ceil();
    // }

    // List<String> slicedImgString = [];
    // if (divisionValue != 0) {
    //   int idx = 0;
    //   for (int i = 0; i < divisionValue; i++) {
    //     if (idx + maxImageSize < fileLength) {
    //       String newImgString = imgString.substring(idx, maxImageSize);
    //       idx += maxImageSize;
    //       print(newImgString);
    //       slicedImgString.add(newImgString);
    //     } else {
    //       String newImgString = imgString.substring(idx);
    //       print(newImgString);
    //       slicedImgString.add(newImgString);
    //     }
        
    //   }
    // }

    // try {
    //   await dr.deleteBackground();
    // } catch (err) {
    //   print(err);
    //   return;
    // }

    // try {
    //   await dr.insertBackground(imgString);
    // } catch (err) {
    //   print(err);
    //   return;
    // }
    // if (slicedImgString.isNotEmpty) {
    //   for (String item in slicedImgString) {
    //     try {
    //       await dr.insertBackground(item);
    //     } catch (err) {
    //       print(err);
    //       return;
    //     }
    //   }
    // } else {
    //   try {
    //     await dr.insertBackground(imgString);
    //   } catch (err) {
    //     print(err);
    //     return;
    //   }
    // }


    // 혹시라도 id 값이 계속 오른다고 당황하지 말자
    // deleteBackground는 테이블 자체를 지우는게 아니니까
    // id는 1번부터 다시 나오는게 아니라 계속 오르는게 당연하다...
    // try {
    //   background = await dr.getBackground();
    // } catch (err) {
    //   print(err);
    //   return;
    // }


    // if (background.isEmpty) {
    //   uint8ListImage.value = [0];
    //   isDefault.value = true;
    // } else {
    //   if (background.length > 1) {
    //     print("여기가 문제");
    //     int tempDataFromBase64String = 0;
    //     for (int i = 0; i < background.length; i++) {
    //       print(Utility.dataFromBase64String(background[i]["background"]));
    //       tempDataFromBase64String += Utility.dataFromBase64String(background[i]["background"]) as int;
    //     }
    //     uint8ListImage.value = [tempDataFromBase64String];
    //   } else {
    //     uint8ListImage.value = [Utility.dataFromBase64String(background[0]["background"])];
    //   }
    //   isDefault.value = false;
    // }

    // uint8ListImage.value = [Utility.dataFromBase64String(background[0]["background"])];
    // isDefault.value = false;
  }

  // Future<void> setDefault() async {
  //   isDefault.value = true;
  //   try {
  //     await dr.deleteBackground();
  //   } catch (err) {
  //     print(err);
  //     return;
  //   }
  // }
  void setDefault() {
    isDefault.value = true;
    prefs.setString('imgPath', '');
  }
}