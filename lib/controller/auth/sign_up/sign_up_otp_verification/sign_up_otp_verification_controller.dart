import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';
import 'package:xremitpro/views/congratulation/congratulation_screen.dart';

import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/common/common_success_model.dart';
import '../../../../backend/services/auth/auth_api_services.dart';
import '../../../../backend/utils/api_method.dart';
import '../../../../routes/routes.dart';

class SignUpOtpVerificationController extends GetxController {
  final pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  var currentText = ''.obs;
  StreamSubscription? streamSubscription;

  changeCurrentText(value) {
    currentText.value = value;
  }

  void redirectScreen() {
    Get.toNamed(Routes.signUpFailureScreen);
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    errorController!.close(); // close the errorController stream
    streamSubscription?.cancel(); // cancel the stream subscription
    super.dispose();
  }

  @override
  void onInit() {
    errorController = StreamController<
        ErrorAnimationType>.broadcast(); // create a broadcast stream
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

  void goToResetPasswordScreen() {
    Get.toNamed(Routes.resetPasswordScreen);
  }

  get onSubmit => emailOtpSubmitProcess();

  _onSubmitEmailCode() {
    Get.to(() => CongratulationScreen(
          title: Strings.congratulations,
          subTitle: Strings.accountSuccessfullyCreate,
          route: Routes.bottomNavBar,
        ));
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _emailOtpSubmitModel;
  CommonSuccessModel get emailOtpSubmitModel => _emailOtpSubmitModel;

  Future<CommonSuccessModel> emailOtpSubmitProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'code': currentText.value,
    };
    await AuthApiServices.emailOtpVerifyApi(body: inputBody).then((value) {
      _emailOtpSubmitModel = value!;

      if (LocalStorage.getTwoFaID()) {
        //  Get.toNamed(Routes.twoFactorVerificationScreen);
      } else {
        _onSubmitEmailCode();
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _emailOtpSubmitModel;
  }

  final _resendLoading = false.obs;
  bool get resendLoading => _resendLoading.value;

  Future<CommonSuccessModel> resendOtpProcess() async {
    _resendLoading.value = true;

    update();

    await AuthApiServices.emailResendProcessApi().then((value) {
      _emailOtpSubmitModel = value!;
      _resendLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _resendLoading.value = false;
    update();
    return _emailOtpSubmitModel;
  }
}
