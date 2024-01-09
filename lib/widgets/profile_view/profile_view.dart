import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xremitpro/controller/drawer/profile_screen_controller.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../bottom_sheet/image_picker_sheet.dart';

class ProfileViewWidget extends StatefulWidget {
  ProfileViewWidget({Key? key, this.withButton = false, this.heightSize = 8.0})
      : super(key: key);

  final bool withButton;
  final double heightSize;
  final customColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.primaryLightColor;

  @override
  State<ProfileViewWidget> createState() => _ProfileViewWidgetState();
}

class _ProfileViewWidgetState extends State<ProfileViewWidget> {
  final controller = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImagePickerBottomSheet(context);
      },
      child: Stack(
        children: [_imageWidget(), _buttonWidget(context)],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Visibility(
      visible: widget.withButton,
      child: Positioned(
        left: 75,
        bottom: 2,
        child: IconButton(
            onPressed: () {},
            icon: Container(
              height: Dimensions.heightSize * 2,
              width: Dimensions.widthSize * 2.4,
              padding: EdgeInsets.all(Dimensions.paddingSize * 0.125),
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CustomColor.blackColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 5),
              ),
              child: CircleAvatar(
                backgroundColor: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightColor,
                child: Icon(Icons.camera_alt,
                    color: Get.isDarkMode
                        ? CustomColor.blackColor
                        : CustomColor.whiteColor,
                    size: Dimensions.iconSizeDefault * .7),
              ),
            )),
      ),
    );
  }

  _imageWidget() {
    return Obx(
      () => Container(
        height: Dimensions.heightSize * widget.heightSize,
        width: Dimensions.heightSize * widget.heightSize,
        padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.radius * 10),
          border: Border.all(color: CustomColor.primaryLightColor, width: 2.5),
        ),
        child: CircleAvatar(
            backgroundColor: Get.isDarkMode
                ? CustomColor.whiteColor
                : CustomColor.primaryLightColor,
            backgroundImage: controller.userImagePath.value == ''
                ? NetworkImage(controller.userImage.value)
                : FileImage(File(controller.userImagePath.value))
                    as ImageProvider),
      ),
    );
  }

  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              controller.chooseImageFromCamera();
              Navigator.of(context).pop();
            },
            fromGallery: () {
              controller.chooseImageFromGallery();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    imageController.setImagePath(pickedFile!.path);
    setState(() {});
  }
}

File? pickedFile;
ImagePicker imagePicker = ImagePicker();

final imageController = Get.put(InputImageController());

class InputImageController extends GetxController {
  var isImagePathSet = false.obs;
  var imagePath = "".obs;

  void setImagePath(String path) {
    imagePath.value = path;
    isImagePathSet.value = true;
  }
}
