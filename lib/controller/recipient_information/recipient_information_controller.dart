import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class RecipientInformationController extends GetxController {
  // all text editing controller
  final enterEmailOrUsername = TextEditingController();

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    enterEmailOrUsername.dispose();

    super.dispose();
  }

  void goToPaymentInformation() {
    Get.toNamed(Routes.paymentInformationScreen);
  }

  void goToAddNewRecipientScreen() {
    Get.toNamed(Routes.addNewRecipientScreen);
  }
}
