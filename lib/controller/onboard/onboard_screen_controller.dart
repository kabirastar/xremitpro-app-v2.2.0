import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/english.dart';
import '../../routes/routes.dart';

class OnboardScreenController extends GetxController {
  RxInt selectedPageIndex = 0.obs;
  var pageController = PageController();

  String? selectText() {
    if (selectedPageIndex.value == 0) {
      return Strings.welcomeToXRemit;
    } else if (selectedPageIndex.value == 1) {
      return Strings.safeAndSecureProcess;
    } else if (selectedPageIndex.value == 2) {
      return Strings.customerSupport;
    }

    return null;
  }

  void goToTrackYourTransactionScreen() {
    Get.toNamed(Routes.trackYourTransaction.tr);
  }

  void goToTransferCalculator() {
    Get.toNamed(Routes.transferCalculatorScreen);
  }

  void goToSignIn() {
    Get.toNamed(Routes.signInScreen);
  }

  void goToSignUp() {
    Get.toNamed(Routes.signUpScreen);
  }
}
