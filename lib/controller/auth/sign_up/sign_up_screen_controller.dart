import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/extensions/custom_extensions.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/sign_up_model.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../language/english.dart';
import '../../../routes/routes.dart';

class SignUpController extends GetxController {
  // all text editing controller

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  RxString countryName = Strings.usa.tr.obs;
  RxString code = "+1".obs;

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  RxBool agreed = false.obs;

  get onSignUp => signUpProcessApi();
  get onSignIn => Routes.signInScreen.toNamed;

  /// >> set loading process & Sign Up Model
  final _isLoading = false.obs;
  late SignUpModel _signUpModel;

  /// >> get loading process & Sign Up Model
  bool get isLoading => _isLoading.value;
  SignUpModel get signUpModel => _signUpModel;

  ///* Sign Up Process Api
  Future<SignUpModel> signUpProcessApi() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text.trim(),
      'policy': 'on',
    };
    await AuthApiServices.signUpProcessApi(body: inputBody).then((value) {
      _signUpModel = value!;
      _goToSavedUser(signUpModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signUpModel;
  }

  void _goToSavedUser(SignUpModel signUpModel) {
    LocalStorage.saveToken(token: signUpModel.data.token);
    LocalStorage.saveIsSmsVerify(
        value: signUpModel.data.user.smsVerified == 0 ? false : true);

    if (LocalStorage.isEmailVerify()) {
      if (signUpModel.data.user.emailVerified == 0) {
        Get.offNamed(Routes.signUpOtpVerificationScreen);
      } else {
        LocalStorage.isLoginSuccess(isLoggedIn: true);
        LocalStorage.saveId(id: signUpModel.data.user.id);
        Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
      }
    } else {
      LocalStorage.isLoginSuccess(isLoggedIn: true);
      LocalStorage.saveId(id: signUpModel.data.user.id);
      Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
    }
  }

  void goToSignInScreen() {
    Get.toNamed(Routes.signInScreen);
  }
}
