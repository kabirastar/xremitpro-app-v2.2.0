import 'dart:async';

import 'package:xremitpro/extensions/custom_extensions.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/basic_settings/basic_settings_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/basic_settings/basic_settings_api_services.dart';
import '../../backend/utils/api_method.dart';
import '../../utils/basic_screen_imports.dart';

class BasicSettingsController extends GetxController
    with BasicSettingsApiServices {
  RxString splashImage = ''.obs;
  RxString onboardImage = ''.obs;
  RxString onBoardTitle = ''.obs;
  RxString onBoardSubTitle = ''.obs;
  RxString appBasicLogoWhite = ''.obs;
  RxString appBasicLogoDark = ''.obs;
  RxString privacyPolicy = ''.obs;
  RxString contactUs = ''.obs;
  RxString aboutUs = ''.obs;
  RxString path = ''.obs;
  RxBool isVisible = false.obs;
  @override
  void onInit() {
    getBasicSettingsApiProcess().then(
      (value) => Timer(const Duration(seconds: 4), () {
        isVisible.value = true;
      }),
    );
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  late BasicSettingsInfoModel _appSettingsModel;
  BasicSettingsInfoModel get appSettingsModel => _appSettingsModel;

  Future<BasicSettingsInfoModel> getBasicSettingsApiProcess() async {
    _isLoading.value = true;
    update();
    await getBasicSettingProcessApi().then((value) {
      _appSettingsModel = value!;
      saveInfo();
      update();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }

  void saveInfo() {
    /// >>> get splash & onboard data

    if (_appSettingsModel.data.splashScreen.first.splashScreenImage != '') {
      var imageSplash =
          _appSettingsModel.data.splashScreen.first.splashScreenImage;

      var imagePath = _appSettingsModel.data.appImagePath.pathLocation;
      splashImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageSplash";
    }

    path.value =
        "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.appImagePath.pathLocation}/";

    if (_appSettingsModel.data.basicSettings.first.siteLogo == '') {
      appBasicLogoWhite.value =
          "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.basicSeetingsImagePaths.defaultImage}";

      appBasicLogoDark.value = appBasicLogoWhite.value;
    } else {
      appBasicLogoWhite.value =
          "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.basicSeetingsImagePaths.pathLocation}/${_appSettingsModel.data.basicSettings.first.siteLogo}";
      appBasicLogoDark.value =
          "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.basicSeetingsImagePaths.pathLocation}/${_appSettingsModel.data.basicSettings.first.siteLogoDark}";
    }
    var data = _appSettingsModel.data.basicSettings.first;
    _setInitialValue(data);
    //  save email verification
    LocalStorage.saveEmailVerify(
        value: _appSettingsModel.data.basicSettings.first.emailVerification);
  }

  _setInitialValue(BasicSetting data) {
    Strings.appName = data.siteName;
    CustomColor.primaryDarkColor = HexColor(data.baseColor);
    CustomColor.primaryLightColor = HexColor(data.baseColor);
  }
}
