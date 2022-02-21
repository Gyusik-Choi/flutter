import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageProvider {
  late final ImagePicker picker = ImagePicker();
  late XFile? image;
  late File file;

  Future<File> takePhoto() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
    return file;
  }

}