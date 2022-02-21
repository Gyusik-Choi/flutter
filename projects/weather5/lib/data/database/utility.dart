import 'dart:convert';
import 'dart:typed_data';

// https://rrtutors.com/tutorials/flutter-image-as-string-in-sqlite-database
class Utility {
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}