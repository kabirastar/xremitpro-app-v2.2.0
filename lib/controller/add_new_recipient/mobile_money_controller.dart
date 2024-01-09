import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xremitpro/backend/services/send_remittance/send_remittance_api_services.dart';

import '../../backend/model/send_remittance/bank_and_mobile_method_model.dart';
import '../../backend/utils/api_method.dart';
import '../../routes/routes.dart';

class MobileMoneyController extends GetxController
    with SendRemittanceApiServices {
  final recipientNameController = TextEditingController();
  final recipientEmailAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final additionalAddressController = TextEditingController();
  final recipientPhoneNumber = TextEditingController();
  final contactNumber = TextEditingController();
  final accountNumberController = TextEditingController();
  final birthdayController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final switchValue = true;
  final countryController = TextEditingController();
  RxString selectCountry = ''.obs;
  RxString selectedDocumentItem = 'NID Card'.obs;
  RxString selectedMobileMethod = ''.obs;
  RxString frontImage = ''.obs;
  RxString backImage = ''.obs;
  @override
  void onInit() {
    getBanksAndMobileMethodProcess();
    super.onInit();
  }

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
  RxString selectedMobileItem = ''.obs;
  RxString selectedCity = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedBank = ''.obs;
  RxString selectedRelationship = ''.obs;
  RxBool cashPickupVisibility = false.obs;
  RxBool bankTransferVisibility = false.obs;
  RxBool mobileMoneyVisibility = false.obs;

  List<String> documentTypeList = [
    'Passport',
    'NID Card',
    'Driving License',
  ];

  RxList<String> mobileMethodList = <String>[].obs;
  List<Bank> countryList = [];

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
    mobileMethodList.clear();
    update();
    await getBanksAndMobileMethodApiProcess().then((value) {
      _banksAndMobileMethodModel = value!;
      selectedMobileMethod.value =
          _banksAndMobileMethodModel.data.mobileMethod.first.name;
      for (var element in _banksAndMobileMethodModel.data.mobileMethod) {
        mobileMethodList.add(element.name);
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

  void goToPaymentInformationScreen() {
    Get.toNamed(Routes.paymentInformationScreen);
  }

  getMobileMethodByCountry() {
    for (var element in _banksAndMobileMethodModel.data.mobileMethod) {
      if (element.country.contains(selectCountry.value)) {
        mobileMethodList.add(element.name);
        selectedMobileMethod.value =
            _banksAndMobileMethodModel.data.mobileMethod.first.name;
        update();
      } else {
        mobileMethodList.clear();
        selectedMobileMethod.value = 'No method found';
        update();
      }
    }
  }
}
