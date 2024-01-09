import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xremitpro/language/language_controller.dart';

import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';

class CustomSnackBar {
  static success(String message) {
    return Get.snackbar(
      Get.find<LanguageController>().getTranslation('success'),
      Get.find<LanguageController>().getTranslation(message),
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize * 0.5,
          vertical: Dimensions.paddingSize * 0.5),
      backgroundColor: CustomColor.greenColor,
      colorText: CustomColor.whiteColor,
      leftBarIndicatorColor:
          const Color.fromARGB(255, 8, 118, 6).withOpacity(0.5),
      progressIndicatorBackgroundColor: CustomColor.redColor,
      isDismissible: true,
      animationDuration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5.0,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
          // Get.close(0);
        },
        child: const Text(
          "Dismiss",
          style: TextStyle(color: CustomColor.whiteColor),
        ),
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: CustomColor.whiteColor,
      ),
    );
  }

  static error(String message) {
    return Get.snackbar(Get.find<LanguageController>().getTranslation('alert'),
        Get.find<LanguageController>().getTranslation(message),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize * 0.5,
            vertical: Dimensions.paddingSize * 0.5),
        backgroundColor: CustomColor.redColor.withOpacity(0.8),
        colorText: CustomColor.whiteColor,
        leftBarIndicatorColor: CustomColor.redColor,
        progressIndicatorBackgroundColor: CustomColor.redColor,
        isDismissible: true,
        animationDuration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
            // Get.close(1);
          },
          child: const Text(
            "Dismiss",
            style: TextStyle(color: CustomColor.whiteColor),
          ),
        ),
        icon: const Icon(
          Icons.warning,
          color: CustomColor.redColor,
        ));
  }
}
