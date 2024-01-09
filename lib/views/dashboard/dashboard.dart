import '/utils/responsive_layout.dart';
import '/views/dashboard/dashboard_mobile.dart';
import '../../utils/basic_screen_imports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: DashboardMobileScreen());
  }
}
