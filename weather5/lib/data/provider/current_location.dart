import 'package:location/location.dart';

class CurrentLocation {
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
}