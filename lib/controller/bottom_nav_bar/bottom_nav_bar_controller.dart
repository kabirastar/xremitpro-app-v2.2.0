import 'package:get/get.dart';

import '../../views/dashboard/dashboard.dart';
import '../../views/drawer_screens/transfer_log_screen/transfer_log_screen.dart';
import '../../views/notification/notification_screen.dart';

class BTMNavController extends GetxController {
  final RxInt selectedIndex = 2.obs;
  final RxBool isRoutesIndex = false.obs;

  final List body = [
    const TransferLogScreen(),

    NotificationScreen(),
    const DashboardScreen(),
    // MoreScreen(),
  ];

  final List appTitleList = ['Home', 'More'];

  RxString appTitle = 'Touch & Send'.obs;
}
