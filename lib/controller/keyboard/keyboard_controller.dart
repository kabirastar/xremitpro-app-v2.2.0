import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/text_labels/custom_title_heading_widget.dart';

class CreateCardController extends GetxController {
  final amountTextController = TextEditingController();
  List<String> totalAmount = [];

  @override
  void dispose() {
    amountTextController.dispose();

    super.dispose();
  }

  @override
  void onInit() {
    amountTextController.text = '0.0';
    super.onInit();
  }

  goToAddMoneyPreviewScreen() {
    Get.toNamed(Routes.paymentInformationScreen);
  }

  RxString selectItem = ''.obs;
  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];
  List currencyList = ['USD', 'BDT'];
  List gatewayList = ['Paypal', 'Stripe'];

  inputItem(int index) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onLongPress: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.clear();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        }
      },
      onTap: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.removeLast();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        } else {
          if (totalAmount.contains('.') && index == 9) {
            return;
          } else {
            totalAmount.add(keyboardItemList[index]);
            amountTextController.text = totalAmount.join('');
            debugPrint(totalAmount.join(''));
          }
        }
      },
      child: Center(
        child: CustomTitleHeadingWidget(
          text: keyboardItemList[index],
          style: Get.isDarkMode
              ? CustomStyle.lightHeading2TextStyle.copyWith(
                  fontSize: Dimensions.headingTextSize3 * 2,
                  color: CustomColor.secondaryLightTextColor,
                )
              : CustomStyle.darkHeading2TextStyle.copyWith(
                  color: CustomColor.secondaryLightTextColor,
                  fontSize: Dimensions.headingTextSize3 * 2,
                ),
        ),
      ),
    );
  }
}
