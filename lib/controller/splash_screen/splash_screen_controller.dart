import 'dart:async';

import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../language/language_controller.dart';
import '../../routes/routes.dart';

final languageController = Get.find<LanguageController>();

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 5), () {
      if (!languageController.isLoading) {
        Get.offAllNamed(
          LocalStorage.isLoggedIn()
              ? Routes.signInScreen
              : LocalStorage.isOnBoardDone()
                  ? Routes.onBoardScreen
                  : Routes.onBoardScreen,
        );
      }
    });
  }
}
