import 'package:location/location.dart';

// 함수명 앞에 _ 붙이면 외부에서 접근이 불가능하다.
// 여기서 외부의 의미는 다른 파일을 의미한다.
// Future<void> _getLocation() async {
Future<List<double>> getLocation() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  double _lat;
  double _long;
  List<double> latAndLong = [];

  Location location = Location();

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return [0.0];
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return [0.0];
    }
  }

  _locationData = await location.getLocation();
  _lat = _locationData.latitude!;
  _long = _locationData.longitude!;

  latAndLong.add(_lat);
  latAndLong.add(_long);
  return latAndLong;
}