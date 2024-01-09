import 'package:xremitpro/controller/basic_settings/basic_settings_controller.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';

class BasicLogoWidget extends StatelessWidget {
  final bool isWhite, isDashBoard;
  BasicLogoWidget({super.key, this.isWhite = false, this.isDashBoard = false});
  final controller = Get.put(BasicSettingsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const Text('')
          : Image.network(
              isWhite
                  ? controller.appBasicLogoWhite.value
                  : controller.appBasicLogoDark.value,
              width: MediaQuery.of(context).size.width * 0.52,
              height: MediaQuery.of(context).size.height *
                  (isDashBoard ? 0.055 : 0.1),
            ),
    );
  }
}
