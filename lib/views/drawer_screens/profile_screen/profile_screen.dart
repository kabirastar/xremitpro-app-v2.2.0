import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../views/drawer_screens/profile_screen/profile_screen_mobile_responsive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProfileScreenMobileResponsive());
  }
}
