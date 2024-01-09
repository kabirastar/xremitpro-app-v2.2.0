import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../backend/model/send_remittance/bank_and_mobile_method_model.dart';
import '../../backend/services/send_remittance/send_remittance_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class BankTransferController extends GetxController
    with SendRemittanceApiServices {
  // all text editing controller
  final first1NameController = TextEditingController();
  final recipientNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final accountNumberController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final ibanNumberController = TextEditingController();

  @override
  void dispose() {
    recipientNameController.dispose();
    emailAddressController.dispose();
    zipCodeController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    accountNumberController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  RxString selectedTransactionItem = ''.obs;
  RxString selectedDocumentItem = 'NID Card'.obs;
  RxString selectedCity = ''.obs;
  RxString selectCountry = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedBank = ''.obs;
  RxString selectedRelationship = ''.obs;
  RxString frontImage = ''.obs;
  RxString backImage = ''.obs;

  List<String> documentTypeList = [
    'Passport',
    'NID Card',
    'Driving License',
  ];

  @override
  void onInit() {
    getBanksAndMobileMethodProcess();
    super.onInit();
  }

  final RxList<String> banksList = <String>[].obs;

  /// >> set loading process & Banks And Mobile Method Model
  final _isLoading = false.obs;
  late BanksAndMobileMethodModel _banksAndMobileMethodModel;

  /// >> get loading process & Banks And Mobile Method Model
  bool get isLoading => _isLoading.value;
  BanksAndMobileMethodModel get banksAndMobileMethodModel =>
      _banksAndMobileMethodModel;

  ///* Get banks and mobile method info api process
  Future<BanksAndMobileMethodModel> getBanksAndMobileMethodProcess() async {
    _isLoading.value = true;
    banksList.clear();
    update();
    await getBanksAndMobileMethodApiProcess().then((value) {
      _banksAndMobileMethodModel = value!;
      selectedBank.value = _banksAndMobileMethodModel.data.banks.first.name;
      for (var element in _banksAndMobileMethodModel.data.banks) {
        banksList.add(element.name);
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _banksAndMobileMethodModel;
  }

  getBanksByCountry() {
    for (var element in _banksAndMobileMethodModel.data.banks) {
      if (element.country.contains(selectCountry.value)) {
        banksList.add(element.name);
        selectedBank.value = _banksAndMobileMethodModel.data.banks.first.name;
        update();
      } else {
        banksList.clear();
        selectedBank.value = 'No bank found';
        update();
      }
    }
  }
}

void goToPaymentInformationScreen() {
  Get.toNamed(Routes.paymentInformationScreen);
}
