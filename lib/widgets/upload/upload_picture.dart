import 'dart:io';

import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../controller/upload/upload_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../bottom_sheet/image_picker_sheet.dart';

File? imageFile;

class ImagesUploadWidget extends StatefulWidget {
  const ImagesUploadWidget(
      {super.key,
      required this.labelName,
      required this.fieldName,
      required this.imageUrl});

  final String labelName;
  final String fieldName;
  final String imageUrl;

  @override
  State<ImagesUploadWidget> createState() => _DropFileState();
}

class _DropFileState extends State<ImagesUploadWidget> {
  final controller = Get.put(UploadImageController());

  Future pickImage(imageSource) async {
    try {
      final image =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
      if (image == null) return;

      imageFile = File(image.path);

      if (controller.listFieldName.isNotEmpty) {
        if (controller.listFieldName.contains(widget.fieldName)) {
          int itemIndex = controller.listFieldName.indexOf(widget.fieldName);
          controller.listFieldName[itemIndex] = widget.fieldName;
          controller.listImagePath[itemIndex] = imageFile!.path;
        } else {
          controller.listImagePath.add(imageFile!.path);
          controller.listFieldName.add(widget.fieldName);
        }
      } else {
        controller.listImagePath.add(imageFile!.path);
        controller.listFieldName.add(widget.fieldName);
      }
      setState(() {
        controller.updateImageData(widget.fieldName, imageFile!.path);
      });
      Get.back();
      // CustomSnackBar.success('$labelName Added');
    } on PlatformException catch (_) {
      // CustomSnackBar.error('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showImagePickerBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius),
          ),
          color: Theme.of(context).colorScheme.background,
        ),
        padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.542,
          right: Dimensions.paddingSize * 0.542,
          bottom: Dimensions.paddingSize * 0.542,
          top: Dimensions.paddingSize * 0.75,
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TitleHeading4Widget(
              text: widget.labelName,
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(Dimensions.heightSize),
            Container(
              decoration: BoxDecoration(
                border: RDottedLineBorder.all(
                  color: Get.isDarkMode
                      ? CustomColor.whiteColor.withOpacity(0.3)
                      : CustomColor.blackColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: Container(
                height: Dimensions.heightSize * 10,
                alignment: Alignment.center,
                margin: EdgeInsets.all(
                  Dimensions.marginSizeHorizontal * 0.25,
                ),
                decoration: controller.getImagePath(widget.fieldName) == null
                    ? widget.imageUrl != ''
                        ? BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.imageUrl),
                            ),
                          )
                        : BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius),
                          )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              controller.getImagePath(widget.fieldName) ?? '',
                            ),
                          ),
                        ),
                      ),
                child: Column(
                  mainAxisAlignment: mainCenter,
                  mainAxisSize: mainMin,
                  children: [
                    Icon(
                      Iconsax.gallery_import5,
                      color: Get.isDarkMode
                          ? CustomColor.whiteColor.withOpacity(0.3)
                          : CustomColor.blackColor.withOpacity(0.3),
                    ),
                    verticalSpace(Dimensions.heightSize * 0.5),
                    TitleHeading4Widget(
                      text: Strings.upload,
                      textOverflow: TextOverflow.fade,
                      color: Get.isDarkMode
                          ? CustomColor.whiteColor.withOpacity(0.3)
                          : CustomColor.blackColor.withOpacity(0.3),
                      fontSize: Dimensions.headingTextSize5,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              pickImage(ImageSource.camera);
            },
            fromGallery: () {
              pickImage(ImageSource.gallery);
            },
          ),
        );
      },
    );
  }
}
