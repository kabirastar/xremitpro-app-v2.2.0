import '/utils/basic_widget_imports.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxString userToken = ''.obs;

  get onResetPassword => resetPasswordProcess();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  /// >> set loading process & Reset Password Model
  final _isLoading = false.obs;
  late CommonSuccessModel _resetPasswordModel;

  /// >> set loading process & Reset Password Model
  bool get isLoading => _isLoading.value;
  CommonSuccessModel get resetPasswordModel => _resetPasswordModel;

  ///* Reset password process
  Future<CommonSuccessModel> resetPasswordProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'token': userToken.value,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text
    };

    await AuthApiServices.resetPasswordApi(body: inputBody).then((value) {
      _resetPasswordModel = value!;

      Get.offAllNamed(Routes.congratulationScreen);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _resetPasswordModel;
  }
}
