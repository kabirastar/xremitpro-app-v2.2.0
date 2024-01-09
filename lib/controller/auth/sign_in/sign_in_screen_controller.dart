import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/extensions/custom_extensions.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/forgot_password_model.dart';
import '../../../backend/model/auth/sign_in_model.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import 'sign_in_otp_verification/otp_verification_controller.dart';

class SignInScreenController extends GetxController {
  // all text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final resetUserEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPassword = TextEditingController();

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    resetUserEmailController.dispose();
    newPasswordController.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  get onSignIn => signInProcess();
  get onForgotPassword => forgotPasswordProcess();
  get onSignUp => Routes.signUpScreen.toNamed;

  /// >> set loading process & Sign In Model
  final _isLoading = false.obs;
  late SignInModel _signInModel;

  /// >> get loading process & Sign In Model
  bool get isLoading => _isLoading.value;
  SignInModel get signInModel => _signInModel;

  ///* Sign in process
  Future<SignInModel> signInProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    await AuthApiServices.signInProcessApi(body: inputBody).then((value) {
      _signInModel = value!;
      _saveDataLocalStorage();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _signInModel;
  }

  _saveDataLocalStorage() {
    LocalStorage.saveIsSmsVerify(
        value: _signInModel.data.user.smsVerified == 0 ? false : true);
    LocalStorage.saveTwoFaID(
        id: _signInModel.data.user.twoFactorStatus == 0 ? false : true);
    LocalStorage.saveKyc(
        id: _signInModel.data.user.kycVerified == 1 ? true : false);

    if (_signInModel.data.user.twoFactorStatus == 1 &&
        _signInModel.data.user.twoFactorVerified == 0) {
      LocalStorage.saveToken(token: signInModel.data.token);
      LocalStorage.saveEmail(email: signInModel.data.user.email);
      LocalStorage.saveId(id: signInModel.data.user.id);
      Get.toNamed(Routes.twoFaOtpVerificationScreen);
    } else if (_signInModel.data.user.emailVerified == 1) {
      debugPrint("----------------VERIFIED");
      _goToSavedUser(signInModel);
    } else if (_signInModel.data.user.emailVerified == 0) {
      debugPrint("----------------EMAIL NOT VERIFIED");
      LocalStorage.saveToken(token: signInModel.data.token);
      LocalStorage.saveId(id: signInModel.data.user.id);
      Get.toNamed(Routes.signUpOtpVerificationScreen);
    }
  }

  void _goToSavedUser(SignInModel signInModel) {
    LocalStorage.saveToken(token: signInModel.data.token);

    LocalStorage.isLoginSuccess(isLoggedIn: true);

    LocalStorage.saveEmail(email: signInModel.data.user.email);
    LocalStorage.saveId(id: signInModel.data.user.id);
    update();
    Get.offAllNamed(Routes.bottomNavBar);
  }

  /// >> set loading process & Forgot Password Model
  final _isForgotPasswordLoading = false.obs;
  late ForgotPasswordModel _forgotPasswordModel;

  /// >> get loading process & Forgot Password Model
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  ForgotPasswordModel get forgotPasswordModel => _forgotPasswordModel;

  ///* Forgot Password Api Process
  Future<ForgotPasswordModel> forgotPasswordProcess() async {
    _isForgotPasswordLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'credentials': resetUserEmailController.text.trim(),
    };
    await AuthApiServices.forgotPasswordProcessApi(body: inputBody)
        .then((value) {
      _forgotPasswordModel = value!;
      goToEmailVerification(_forgotPasswordModel.data.token);
      _isForgotPasswordLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotPasswordLoading.value = false;
    update();
    return _forgotPasswordModel;
  }

  final controller = Get.put(SignInOtpVerificationController());
  void goToEmailVerification(String token) {
    Get.back();
    controller.userToken.value = token;
    debugPrint("\u001b[38;5;208____${controller.userToken.value}\u001b[0m____");
    Get.toNamed(Routes.otpVerification);
  }

  goToSignInScreen() {
    Get.toNamed(Routes.signInScreen);
  }

  getOffAll() {
    Get.offAllNamed(Routes.signInScreen);
  }

  goToSignUpScreen() {
    Get.toNamed(Routes.signUpScreen);
  }

  goToMoneyTransferScreen() {
    Get.offAllNamed(Routes.bottomNavBar);
  }
}
