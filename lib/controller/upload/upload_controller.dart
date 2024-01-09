import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

File? pickedFile;
ImagePicker imagePicker = ImagePicker();

class UploadImageController extends GetxController {
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  String? getImagePath(String fieldName) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      return listImagePath[itemIndex];
    }
    return null;
  }
}
