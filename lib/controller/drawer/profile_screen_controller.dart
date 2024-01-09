// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xremitpro/backend/local_storage/local_storage.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/routes/routes.dart';

import '../../backend/model/common/common_success_model.dart';
import '../../backend/model/profile/profile_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/profile/profile_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../language/english.dart';

class ProfileScreenController extends GetxController with ProfileApiServices {
  // all text editing controller
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final stateController = TextEditingController();
  final passwordController = TextEditingController();
  final zipCodeController = TextEditingController();
  final additionalAddressController = TextEditingController();
  final cityController = TextEditingController();
  final birthdayController = TextEditingController();
  final addressController = TextEditingController();
  final countryController = TextEditingController();

  RxString selectedCity = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedRelations = ''.obs;

  List<String> city = [
    Strings.dhaka.tr,
    Strings.khulna.tr,
    Strings.rangpur.tr,
  ];

  List<String> gender = [
    Strings.male.tr,
    Strings.female.tr,
  ];
  List<String> relations = [
    Strings.single.tr,
    Strings.married.tr,
    Strings.divorced.tr,
    Strings.widow.tr,
  ];

  get onDeleteProcess => profileDeleteProcess();

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  /// >>> set value for country
  RxString selectCountry = 'United States'.obs;
  RxString selectCountryCode = ''.obs;

  RxString userImagePath = ''.obs;
  RxString userEmailAddress = ''.obs;
  RxString userFullName = ''.obs;
  RxString userImage = ''.obs;
  RxString defaultImage = ''.obs;

  //-> Image Picker
  RxBool isImagePathSet = false.obs;
  File? image;
  ImagePicker picker = ImagePicker();
  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  get onUpdateProfile => isImagePathSet.value
      ? profileUpdateWithImageProcess()
      : profileUpdateWithOutImageProcess();
  @override
  void onInit() {
    getProfileInfoProcess();
    super.onInit();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late ProfileInfoModel _profileInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;
  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get profile info api process
  Future<ProfileInfoModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await getProfileInfoProcessApi().then((value) {
      _profileInfoModel = value!;
      _setData(_profileInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }

  void _setData(ProfileInfoModel profileModel) {
    var data = profileModel.data;
    userFullName.value = '${data.userInfo.firstname} ${data.userInfo.lastname}';
    firstNameController.text = data.userInfo.firstname;
    lastNameController.text = data.userInfo.lastname;
    mobileNumberController.text = data.userInfo.fullMobile;
    addressController.text = data.userInfo.address;
    countryController.text = data.userInfo.country;

    ///addressController.text = data.user.address.address;
    cityController.text = data.userInfo.city;
    stateController.text = data.userInfo.state;
    zipCodeController.text = data.userInfo.zip;
    userEmailAddress.value = data.userInfo.email;
    selectCountry.value = data.userInfo.country;

    LocalStorage.saveEmail(email: data.userInfo.email);
    LocalStorage.saveName(name: userFullName.value);
    // LocalStorage.saveNumber(num: data.user.fullMobile);
    if (data.userInfo.image != '') {
      userImage.value =
          '${ApiEndpoint.mainDomain}/${data.imagePaths.pathLocation}/' +
              data.userInfo.image;
    } else {
      userImage.value =
          '${ApiEndpoint.mainDomain}/${data.imagePaths.defaultImage}';
    }
    if (data.userInfo.kycVerified == 1) {
      LocalStorage.saveUserVerified(value: true);
    } else {
      LocalStorage.saveUserVerified(value: false);
    }
    update();
  }

  /// >> set loading process & profile update model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _profileUpdateModel;

  /// >> get loading process & profile update model
  bool get isUpdateLoading => _isUpdateLoading.value;
  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  Future<CommonSuccessModel> profileUpdateWithOutImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'phone': mobileNumberController.text,
      'country': selectCountry.value,
      'city': cityController.text,
      'state': stateController.text,
      'zip_code': zipCodeController.text,
      'address': addressController.text,
    };

    await updateProfileWithoutImageApi(body: inputBody).then((value) {
      _profileUpdateModel = value!;
      getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'phone': mobileNumberController.text,
      'country': selectCountry.value,
      'city': cityController.text,
      'state': stateController.text,
      'phone_code': selectCountryCode.value,
      'zip_code': zipCodeController.text,
      'address': addressController.text,
    };

    await updateProfileWithImageApi(
      body: inputBody,
      filepath: userImagePath.value,
    ).then((value) {
      _profileUpdateModel = value!;
      getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  /// Profile delete process

  /// >> set loading process & Profile Delete Model
  final _isDeleteLoading = false.obs;
  late CommonSuccessModel _profileDeleteModel;

  /// >> get loading process & Profile Delete Model
  bool get isDeleteLoading => _isDeleteLoading.value;
  CommonSuccessModel get profileDeleteModel => _profileDeleteModel;

  Future<CommonSuccessModel> profileDeleteProcess() async {
    _isDeleteLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {};

    await deleteProfileProcessApi(body: inputBody).then((value) {
      _profileDeleteModel = value!;
      LocalStorage.signOut();
      Routes.signInScreen.offAllNamed;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isDeleteLoading.value = false;
    update();
    return _profileDeleteModel;
  }
}
