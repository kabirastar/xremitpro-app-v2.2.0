import 'package:xremitpro/controller/notification/notification_controller.dart';

import '../../../utils/responsive_layout.dart';
import '../../../views/notification/notification_screen_mobile.dart';
import '../../utils/basic_screen_imports.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: NotificationScreenMobile(controller: controller),
    );
  }
}
