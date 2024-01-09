import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../views/drawer_screens/change_password_screen/change_password_mobile_responsive.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ChangePasswordMobileResponsive(),
    );
  }
}
