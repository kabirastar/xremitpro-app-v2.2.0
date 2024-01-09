import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xremitpro/backend/model/common/common_success_model.dart';
import '../../../../backend/model/auth/otp_verification_model.dart';
import '../../../../backend/services/auth/auth_api_services.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../routes/routes.dart';
import '../reset_password_controller.dart';

class SignInOtpVerificationController extends GetxController {
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;
  StreamSubscription? streamSubscription;
  RxString userToken = ''.obs;
  changeCurrentText(value) {
    currentText.value = value;
  }

  get onOtpVerify => otpVerifyProcess();
  @override
  void dispose() {
    pinCodeController.dispose();
    errorController!.close(); // close the errorController stream
    streamSubscription?.cancel(); // cancel the stream subscription
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<ErrorAnimationType>.broadcast();
    timerInit();
    super.onInit();
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (minuteRemaining.value != 0) {
        secondsRemaining.value--;
        if (secondsRemaining.value == 0) {
          secondsRemaining.value = 59;
          minuteRemaining.value = 0;
        }
      } else if (minuteRemaining.value == 0 && secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  RxInt secondsRemaining = 59.obs;
  RxInt minuteRemaining = 01.obs;
  RxBool enableResend = false.obs;
  Timer? timer;

  resendCode() {
    timer?.cancel();
    secondsRemaining.value = 59;
    minuteRemaining.value = 01;
    enableResend.value = false;
    timerInit();
    resendOtpProcess();
  }

  /// >> set loading process & Otp Verification Model
  final _isLoading = false.obs;
  late OtpVerificationModel _otpVerificationModel;

  /// >> get loading process & Otp Verification Model
  bool get isLoading => _isLoading.value;
  OtpVerificationModel get otpVerificationModel => _otpVerificationModel;

  ///* Otp verify process
  Future<OtpVerificationModel> otpVerifyProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': currentText.value,
      'token': userToken.value
    };
    await AuthApiServices.forgetPassVerifyOTPApi(body: inputBody).then((value) {
      _otpVerificationModel = value!;

      goToResetPasswordScreen(_otpVerificationModel.data.token);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _otpVerificationModel;
  }

  final resetPassController = Get.put(ResetPasswordController());
  void goToResetPasswordScreen(String token) {
    resetPassController.userToken.value = token;
    Get.offNamed(Routes.resetPasswordScreen);
  }

  /// >> set loading process & Forgot Password Model
  final _isForgotPasswordLoading = false.obs;
  late CommonSuccessModel _forgotPasswordModel;

  /// >> get loading process & Forgot Password Model
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  CommonSuccessModel get forgotPasswordModel => _forgotPasswordModel;

  ///* Resend otp process
  Future<CommonSuccessModel> resendOtpProcess() async {
    _isForgotPasswordLoading.value = true;
    update();

    await AuthApiServices.forgotPasswordResendApi(userToken.value)
        .then((value) {
      _forgotPasswordModel = value!;
      _isForgotPasswordLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotPasswordLoading.value = false;
    update();
    return _forgotPasswordModel;
  }

  void listenToStream() {
    // cancel any existing subscription
    streamSubscription?.cancel();

    // listen to the stream
    streamSubscription = errorController!.stream.listen((errorAnimationType) {
      // do something with the error
    });
  }
}
