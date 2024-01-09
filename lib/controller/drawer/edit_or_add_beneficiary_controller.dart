import 'package:xremitpro/backend/model/common/common_success_model.dart';
import 'package:xremitpro/controller/add_new_recipient/mobile_money_controller.dart';
import 'package:xremitpro/controller/drawer/saved_beneficairy_controller.dart';
import 'package:xremitpro/controller/upload/upload_controller.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';

import '../../backend/model/beneficiary/beneficiary_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/recipients/beneficiary_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../add_new_recipient/add_new_recipient_controller.dart';
import '../dashboard/dashboard_controller.dart';
import '../send_remittance/beneficiaries_controller.dart';

class EditOrAddBeneficiaryController extends GetxController
    with BeneficiariesApiServices {
  final mobileMoneyController = Get.put(MobileMoneyController());
  final bankTransferController = Get.put(BankTransferController());
  final typeController = Get.put(DashboardController());
  final imageController = Get.put(UploadImageController());
  RxString selectMethod = ''.obs;
  RxString selectBeneficiaryId = ''.obs;
  RxBool isAddingMode = false.obs;
  RxBool onSendProcess = false.obs;

  /// >> set loading process & Beneficiary Info Model
  final _isLoading = false.obs;
  late BeneficiaryInfoModel _beneficiaryInfoModel;

  /// >> get loading process & Beneficiary Info Model
  bool get isLoading => _isLoading.value;
  BeneficiaryInfoModel get beneficiaryInfoModel => _beneficiaryInfoModel;

  get onUpdateProcess => imageController.listImagePath.isEmpty
      ? updateBeneficiaryApiProcess()
      : updateBeneficiaryApiProcessWithImage();
  get onAddRecipient => imageController.listImagePath.isEmpty
      ? addBeneficiaryApiProcess()
      : addBeneficiaryApiProcessWithImage();

  ///* Get beneficiary info api process
  Future<BeneficiaryInfoModel> getBeneficiaryApiProcess(int id) async {
    _isLoading.value = true;
    update();
    await beneficiaryGetApiProcess(
      id,
      isEditMode: true,
    ).then((value) {
      _beneficiaryInfoModel = value!;
      var method = _beneficiaryInfoModel.data.beneficiaries.first.method;
      typeController.selectTransactionType.value = method;
      debugPrint(selectMethod.value);
      if (method.contains('Bank')) {
        _getBankTransferBeneficiaryInfo(_beneficiaryInfoModel);
      } else if (method.contains('Mobile')) {
        _getMobileMoneyBeneficiaryInfo(_beneficiaryInfoModel);
      } else {}

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _beneficiaryInfoModel;
  }

  _getMobileMoneyBeneficiaryInfo(BeneficiaryInfoModel beneficiaryInfoModel) {
    var data = beneficiaryInfoModel.data.beneficiaries.first;
    mobileMoneyController.recipientNameController.text = data.firstName;
    mobileMoneyController.recipientEmailAddressController.text = data.email;
    mobileMoneyController.zipCodeController.text = data.zipCode;
    mobileMoneyController.additionalAddressController.text = data.address;
    mobileMoneyController.recipientPhoneNumber.text = data.phone;
    mobileMoneyController.accountNumberController.text = data.accountNumber;
    mobileMoneyController.middleNameController.text = data.middleName;
    mobileMoneyController.lastNameController.text = data.lastName;
    mobileMoneyController.countryController.text = data.country;
    mobileMoneyController.stateController.text = data.state;
    mobileMoneyController.cityController.text = data.city;
    mobileMoneyController.selectedMobileMethod.value = data.mobileName;
    if (data.frontImage != '') {
      mobileMoneyController.frontImage.value =
          "${ApiEndpoint.mainDomain}/public/frontend/images/site-section/${data.frontImage}";
    }
    if (data.backImage != '') {
      mobileMoneyController.backImage.value =
          "${ApiEndpoint.mainDomain}/public/frontend/images/site-section/${data.backImage}";
    }
  }

  _getBankTransferBeneficiaryInfo(BeneficiaryInfoModel beneficiaryInfoModel) {
    var data = beneficiaryInfoModel.data.beneficiaries.first;
    bankTransferController.first1NameController.text = data.firstName;
    bankTransferController.emailAddressController.text = data.email;
    bankTransferController.zipCodeController.text = data.zipCode;
    bankTransferController.addressController.text = data.address;
    bankTransferController.phoneNumberController.text = data.phone;
    bankTransferController.accountNumberController.text = data.accountNumber;
    bankTransferController.middleNameController.text = data.middleName;
    bankTransferController.lastNameController.text = data.lastName;
    bankTransferController.countryController.text = data.country;
    bankTransferController.stateController.text = data.state;
    bankTransferController.cityController.text = data.city;
    bankTransferController.selectedBank.value = data.bankName;
    bankTransferController.ibanNumberController.text = data.ibanNumber;

    if (data.frontImage != '') {
      bankTransferController.frontImage.value =
          "${ApiEndpoint.mainDomain}/public/frontend/images/site-section/${data.frontImage}";
    }
    if (data.backImage != '') {
      bankTransferController.backImage.value =
          "${ApiEndpoint.mainDomain}/public/frontend/images/site-section/${data.backImage}";
    }
  }

  /// >> set loading process & Beneficiary Update Model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _beneficiaryUpdateModel;

  /// >> get loading process & Beneficiary Update Model
  bool get isUpdateLoading => _isUpdateLoading.value;
  CommonSuccessModel get beneficiaryUpdateModel => _beneficiaryUpdateModel;

  ///* Update beneficiary api process
  Future<CommonSuccessModel> updateBeneficiaryApiProcess() async {
    _isUpdateLoading.value = true;
    update();
    debugPrint(selectBeneficiaryId.value);
    Map<String, dynamic> bankTransferBody = {
      'first_name': bankTransferController.first1NameController.text,
      'middle_name': bankTransferController.middleNameController.text,
      'last_name': bankTransferController.lastNameController.text,
      'email': bankTransferController.emailAddressController.text,
      'country': bankTransferController.selectCountry.value,
      'city': bankTransferController.selectedCity.value,
      'state': bankTransferController.stateController.text,
      'zip_code': bankTransferController.zipCodeController.text,
      'phone': bankTransferController.phoneNumberController.text,
      'method': typeController.selectTransactionType.value,
      'bank_name': bankTransferController.selectedBank.value,
      'iban_number': bankTransferController.ibanNumberController.text,
      'address': bankTransferController.addressController.text,
      'document_type': bankTransferController.selectedDocumentItem.value,
      'id': selectBeneficiaryId.value,
    };

    Map<String, dynamic> mobileMoneyBody = {
      'first_name': mobileMoneyController.recipientNameController.text,
      'middle_name': mobileMoneyController.middleNameController.text,
      'last_name': mobileMoneyController.lastNameController.text,
      'email': mobileMoneyController.recipientEmailAddressController.text,
      'country': mobileMoneyController.selectCountry.value,
      'city': mobileMoneyController.selectedCity.value,
      'state': mobileMoneyController.stateController.text,
      'zip_code': mobileMoneyController.zipCodeController.text,
      'phone': mobileMoneyController.recipientPhoneNumber.text,
      'method': typeController.selectTransactionType.value,
      'address': mobileMoneyController.additionalAddressController.text,
      'document_type': mobileMoneyController.selectedDocumentItem.value,
      'id': selectBeneficiaryId.value,
      "mobile_name": mobileMoneyController.selectedMobileMethod.value,
      "account_number": mobileMoneyController.accountNumberController.text,
    };
    //mobileMoneyBody
    await updateBeneficiaryProcessApi(
      body: typeController.selectTransactionType.value == 'Mobile Money'
          ? mobileMoneyBody
          : bankTransferBody,
    ).then((value) {
      _beneficiaryUpdateModel = value!;
      final controller = Get.put(SavedBeneficiaryController());
      final beneficiariesController = Get.put(BeneficiariesController());
      beneficiariesController.getBeneficiariesListProcess();
      if (onSendProcess.value) {
        controller.getBeneficiaryApiProcess();
      }
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isUpdateLoading.value = false;
    });

    _isUpdateLoading.value = false;
    update();
    return _beneficiaryUpdateModel;
  }

  Future<CommonSuccessModel> updateBeneficiaryApiProcessWithImage() async {
    _isUpdateLoading.value = true;
    debugPrint('With Image');
    update();
    debugPrint(selectBeneficiaryId.value);
    Map<String, String> bankTransferBody = {
      'first_name': bankTransferController.first1NameController.text,
      'middle_name': bankTransferController.middleNameController.text,
      'last_name': bankTransferController.lastNameController.text,
      'email': bankTransferController.emailAddressController.text,
      'country': bankTransferController.selectCountry.value,
      'city': bankTransferController.selectedCity.value,
      'state': bankTransferController.stateController.text,
      'zip_code': bankTransferController.zipCodeController.text,
      'phone': bankTransferController.phoneNumberController.text,
      'method': typeController.selectTransactionType.value,
      'bank_name': bankTransferController.selectedBank.value,
      'iban_number': bankTransferController.ibanNumberController.text,
      'address': bankTransferController.addressController.text,
      'document_type': bankTransferController.selectedDocumentItem.value,
      'id': selectBeneficiaryId.value,
    };

    Map<String, String> mobileMoneyBody = {
      'first_name': mobileMoneyController.recipientNameController.text,
      'middle_name': mobileMoneyController.middleNameController.text,
      'last_name': mobileMoneyController.lastNameController.text,
      'email': mobileMoneyController.recipientEmailAddressController.text,
      'country': mobileMoneyController.selectCountry.value,
      'city': mobileMoneyController.selectedCity.value,
      'state': mobileMoneyController.stateController.text,
      'zip_code': mobileMoneyController.zipCodeController.text,
      'phone': mobileMoneyController.recipientPhoneNumber.text,
      'method': typeController.selectTransactionType.value,
      'address': mobileMoneyController.additionalAddressController.text,
      'document_type': mobileMoneyController.selectedDocumentItem.value,
      'id': selectBeneficiaryId.value,
      "mobile_name": mobileMoneyController.selectedMobileMethod.value,
      "account_number": mobileMoneyController.accountNumberController.text,
    };
    //mobileMoneyBody
    await updateBeneficiaryProcessWithImageApi(
      body: typeController.selectTransactionType.value == 'Mobile Money'
          ? mobileMoneyBody
          : bankTransferBody,
      fieldList: imageController.listFieldName,
      pathList: imageController.listImagePath,
    ).then((value) {
      _beneficiaryUpdateModel = value!;
      imageController.listFieldName.clear();
      imageController.listImagePath.clear();
      final controller = Get.put(SavedBeneficiaryController());
      final beneficiariesController = Get.put(BeneficiariesController());
      beneficiariesController.getBeneficiariesListProcess();
      if (onSendProcess.value) {
        controller.getBeneficiaryApiProcess();
      }
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isUpdateLoading.value = false;
    });

    _isUpdateLoading.value = false;
    update();
    return _beneficiaryUpdateModel;
  }

  /// Add process

  /// >> set loading process & Beneficiary Store Model
  final _isAddLoading = false.obs;
  late CommonSuccessModel _beneficiaryStoreModel;

  /// >> get loading process & Beneficiary Store Model
  bool get isAddLoading => _isAddLoading.value;
  CommonSuccessModel get beneficiaryStoreModel => _beneficiaryStoreModel;

  ///* Add beneficiary api process
  Future<CommonSuccessModel> addBeneficiaryApiProcess() async {
    _isAddLoading.value = true;
    update();
    debugPrint(selectBeneficiaryId.value);
    Map<String, dynamic> bankTransferBody = {
      'first_name': bankTransferController.first1NameController.text,
      'middle_name': bankTransferController.middleNameController.text,
      'last_name': bankTransferController.lastNameController.text,
      'email': bankTransferController.emailAddressController.text,
      'country': bankTransferController.selectCountry.value,
      'city': bankTransferController.selectedCity.value,
      'state': bankTransferController.stateController.text,
      'zip_code': bankTransferController.zipCodeController.text,
      'phone': bankTransferController.phoneNumberController.text,
      'method': typeController.selectTransactionType.value,
      'bank_name': bankTransferController.selectedBank.value,
      'iban_number': bankTransferController.ibanNumberController.text,
      'address': bankTransferController.addressController.text,
      'document_type': bankTransferController.selectedDocumentItem.value,
    };

    Map<String, dynamic> mobileMoneyBody = {
      'first_name': mobileMoneyController.recipientNameController.text,
      'middle_name': mobileMoneyController.middleNameController.text,
      'last_name': mobileMoneyController.lastNameController.text,
      'email': mobileMoneyController.recipientEmailAddressController.text,
      'country': mobileMoneyController.selectCountry.value,
      'city': mobileMoneyController.selectedCity.value,
      'state': mobileMoneyController.stateController.text,
      'zip_code': mobileMoneyController.zipCodeController.text,
      'phone': mobileMoneyController.contactNumber.text,
      'method': typeController.selectTransactionType.value,
      'address': mobileMoneyController.additionalAddressController.text,
      'document_type': mobileMoneyController.selectedDocumentItem.value,
      "mobile_name": mobileMoneyController.selectedMobileMethod.value,
      "account_number": mobileMoneyController.recipientPhoneNumber.text,
    };
    await storeBeneficiaryProcessApi(
      body: typeController.selectTransactionType.value == 'Mobile Money'
          ? mobileMoneyBody
          : bankTransferBody,
    ).then((value) {
      _beneficiaryStoreModel = value!;
      clear();
      final controller = Get.put(SavedBeneficiaryController());
      final beneficiariesController = Get.put(BeneficiariesController());
      beneficiariesController.getBeneficiariesListProcess();
      if (onSendProcess.value) {
        controller.getBeneficiaryApiProcess();
      }

      _isAddLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isAddLoading.value = false;
    });

    _isAddLoading.value = false;
    update();
    return _beneficiaryStoreModel;
  }

  Future<CommonSuccessModel> addBeneficiaryApiProcessWithImage() async {
    _isAddLoading.value = true;
    update();
    debugPrint(selectBeneficiaryId.value);
    Map<String, String> bankTransferBody = {
      'first_name': bankTransferController.first1NameController.text,
      'middle_name': bankTransferController.middleNameController.text,
      'last_name': bankTransferController.lastNameController.text,
      'email': bankTransferController.emailAddressController.text,
      'country': bankTransferController.selectCountry.value,
      'city': bankTransferController.selectedCity.value,
      'state': bankTransferController.stateController.text,
      'zip_code': bankTransferController.zipCodeController.text,
      'phone': bankTransferController.phoneNumberController.text,
      'method': typeController.selectTransactionType.value,
      'bank_name': bankTransferController.selectedBank.value,
      'iban_number': bankTransferController.ibanNumberController.text,
      'address': bankTransferController.addressController.text,
      'document_type': bankTransferController.selectedDocumentItem.value,
    };

    Map<String, String> mobileMoneyBody = {
      'first_name': mobileMoneyController.recipientNameController.text,
      'middle_name': mobileMoneyController.middleNameController.text,
      'last_name': mobileMoneyController.lastNameController.text,
      'email': mobileMoneyController.recipientEmailAddressController.text,
      'country': mobileMoneyController.selectCountry.value,
      'city': mobileMoneyController.selectedCity.value,
      'state': mobileMoneyController.stateController.text,
      'zip_code': mobileMoneyController.zipCodeController.text,
      'phone': mobileMoneyController.contactNumber.text,
      'method': typeController.selectTransactionType.value,
      'address': mobileMoneyController.additionalAddressController.text,
      'document_type': mobileMoneyController.selectedDocumentItem.value,
      "mobile_name": mobileMoneyController.selectedMobileMethod.value,
      "account_number": mobileMoneyController.recipientPhoneNumber.text,
    };
    await storeBeneficiaryProcessApiWithImage(
      body: typeController.selectTransactionType.value == 'Mobile Money'
          ? mobileMoneyBody
          : bankTransferBody,
      fieldList: imageController.listFieldName,
      pathList: imageController.listImagePath,
    ).then((value) {
      _beneficiaryStoreModel = value!;
      imageController.listFieldName.clear();
      imageController.listImagePath.clear();
      clear();
      final controller = Get.put(SavedBeneficiaryController());
      final beneficiariesController = Get.put(BeneficiariesController());
      beneficiariesController.getBeneficiariesListProcess();
      if (onSendProcess.value) {
        controller.getBeneficiaryApiProcess();
      }

      _isAddLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isAddLoading.value = false;
    });

    _isAddLoading.value = false;
    update();
    return _beneficiaryStoreModel;
  }

  /// >> set loading process & Beneficiary Delete Model
  final _isDeleteLoading = false.obs;
  late CommonSuccessModel _beneficiaryDeleteModel;

  /// >> get loading process & Beneficiary Delete Model
  bool get isDeleteLoading => _isDeleteLoading.value;
  CommonSuccessModel get beneficiaryDeleteModel => _beneficiaryDeleteModel;

  ///* delete beneficiary api process
  Future<CommonSuccessModel> deleteBeneficiaryProcess() async {
    _isAddLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {"id": selectBeneficiaryId.value};
    await deleteBeneficiaryProcessApi(
      body: inputBody,
    ).then((value) {
      _beneficiaryDeleteModel = value!;
      final controller = Get.put(SavedBeneficiaryController());
      controller.getBeneficiaryApiProcess();
      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isDeleteLoading.value = false;
    update();
    return _beneficiaryDeleteModel;
  }

  clear() {
    // Bank Transfer
    bankTransferController.first1NameController.clear();
    bankTransferController.middleNameController.clear();
    bankTransferController.lastNameController.clear();
    bankTransferController.emailAddressController.clear();
    bankTransferController.stateController.clear();
    bankTransferController.zipCodeController.clear();
    bankTransferController.phoneNumberController.clear();
    bankTransferController.ibanNumberController.clear();
    bankTransferController.addressController.clear();
    // Mobile
    mobileMoneyController.recipientNameController.clear();
    mobileMoneyController.middleNameController.clear();
    mobileMoneyController.lastNameController.clear();
    mobileMoneyController.recipientEmailAddressController.clear();
    mobileMoneyController.stateController.clear();
    mobileMoneyController.zipCodeController.clear();
    mobileMoneyController.contactNumber.clear();
    mobileMoneyController.additionalAddressController.clear();
    mobileMoneyController.recipientPhoneNumber.clear();
  }
}
