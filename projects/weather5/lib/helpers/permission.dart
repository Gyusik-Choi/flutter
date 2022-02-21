import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermission() async {
  bool isGrant = true;

  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
  ].request();

  statuses.forEach((permission, permissionStatus) {
    if (permissionStatus.isGranted == false) {
      isGrant = false;
    }
  });

  return isGrant;
}