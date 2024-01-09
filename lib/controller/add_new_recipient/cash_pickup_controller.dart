import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/routes/routes.dart';
import '../../language/english.dart';

class CashPickupController extends GetxController {
  final recipientNameController = TextEditingController();
  final recipientEmailAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final additionalAddressController = TextEditingController();
  final recipientPhoneNumber = TextEditingController();
  final accountNumberController = TextEditingController();
  final birthdayController = TextEditingController();
  RxString countryName = Strings.usa.tr.obs;

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    recipientNameController.dispose();
    recipientEmailAddressController.dispose();
    zipCodeController.dispose();
    additionalAddressController.dispose();
    recipientPhoneNumber.dispose();
    accountNumberController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  RxString selectedTransactionItem = ''.obs;
  RxString selectedCity = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedBank = ''.obs;
  RxString selectedRelationship = ''.obs;
  RxBool cashPickupVisibility = false.obs;
  RxBool bankTransferVisibility = false.obs;
  RxBool mobileMoneyVisibility = false.obs;

  List<String> transactionType = [
    Strings.cashPickup.tr,
    Strings.bankTransfer.tr,
    Strings.mobileMoney.tr,
  ];

  List<String> city = [
    Strings.dhaka.tr,
    Strings.khulna.tr,
    Strings.rangpur.tr,
  ];
  List<String> gender = [
    Strings.male.tr,
    Strings.female.tr,
  ];
  List<String> bank = [
    Strings.unitedBank.tr,
    Strings.cityBank.tr,
    Strings.brackBank.tr,
  ];
  List<String> relationship = [
    Strings.familyRelation.tr,
    Strings.friendshipRelation.tr,
    Strings.acquaintancesRelation.tr,
    Strings.workOrProfessionalRelation.tr,
    Strings.teacherOrStudentRelation.tr,
    Strings.communityOrGroupRelation.tr,
    Strings.placeBasedRelationships.tr,
    Strings.landlordOrTenantRelationships.tr,
  ];

  RxBool selectItem() {
    if (selectedTransactionItem.value == Strings.bankTransfer) {
      cashPickupVisibility.value = false;
      bankTransferVisibility.value = true;
      mobileMoneyVisibility.value = false;

      return bankTransferVisibility;
    }

    return false.obs;
  }

  RxBool selectItemMobileMoney() {
    if (selectedTransactionItem.value == Strings.bankTransfer) {
      cashPickupVisibility.value = false;
      bankTransferVisibility.value = false;
      mobileMoneyVisibility.value = true;

      return mobileMoneyVisibility;
    }

    return false.obs;
  }

  RxBool selectItemCashPickup() {
    if (selectedTransactionItem.value == Strings.bankTransfer) {
      cashPickupVisibility.value = true;
      bankTransferVisibility.value = false;
      mobileMoneyVisibility.value = false;

      return cashPickupVisibility;
    }

    return false.obs;
  }

  void goToPaymentInformation() {
    Get.toNamed(Routes.paymentInformationScreen);
  }
}
