import 'package:xremitpro/controller/basic_settings/basic_settings_controller.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';

class SplashScreenMobileLayout extends StatelessWidget {
  SplashScreenMobileLayout({
    super.key,
  });
  final controller = Get.put(BasicSettingsController());
  final languageController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          controller.splashImage.value,
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
        Visibility(
          visible: languageController.isLoading && controller.isVisible.value,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height * 0.2,
              left: MediaQuery.sizeOf(context).width * 0.15,
              right: MediaQuery.sizeOf(context).width * 0.15,
            ),
            child: LinearProgressIndicator(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
