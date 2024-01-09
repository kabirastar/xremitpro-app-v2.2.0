import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../../backend/utils/custom_snackbar.dart';
import '../../../language/english.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../controller/payment_information/payment_information_controller.dart';
import '../bottom_sheet/image_picker_sheet.dart';

File? imageFile;

class ManualPaymentImageWidget extends StatefulWidget {
  const ManualPaymentImageWidget({
    Key? key,
    required this.labelName,
    required this.fieldName,
  }) : super(key: key);

  final String labelName;
  final String fieldName;

  @override
  State<ManualPaymentImageWidget> createState() =>
      _ManualPaymentImageWidgetState();
}

class _ManualPaymentImageWidgetState extends State<ManualPaymentImageWidget> {
  final controller = Get.put(PaymentInformationController());

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

      CustomSnackBar.success('${widget.labelName} Added');
    } on PlatformException catch (e) {
      CustomSnackBar.error('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImagePickerBottomSheet(context);
      },
      child: Card(
        color: Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).colorScheme.background,
        shadowColor: CustomColor.blackColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.75,
            right: Dimensions.paddingSize * 0.75,
            top: Dimensions.paddingSize * 0.46,
            bottom: Dimensions.paddingSize * 0.46,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelName,
                style: CustomStyle.darkHeading4TextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode
                      ? CustomColor.whiteColor
                      : CustomColor.primaryLightTextColor,
                ),
              ),
              verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
              Container(
                height: controller.getImagePath(widget.fieldName) == null
                    ? null
                    : MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    border: RDottedLineBorder.all(
                      color: CustomColor.primaryLightColor,
                    ),
                    image: controller.getImagePath(widget.fieldName) == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                controller.getImagePath(widget.fieldName) ?? '',
                              ),
                            ),
                          )),
                child: controller.getImagePath(widget.fieldName) == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: CustomColor.primaryLightColor,
                          ),
                          SizedBox(
                            width: Dimensions.widthSize * 0.5,
                          ),
                          Text(
                            Strings.uploadImage,
                            style: TextStyle(
                              color: CustomColor.primaryLightColor,
                              fontSize: Dimensions.headingTextSize3,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      )
                    : const Row(children: []),
              ),
            ],
          ),
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
              Navigator.of(context).pop();
            },
            fromGallery: () {
              pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
