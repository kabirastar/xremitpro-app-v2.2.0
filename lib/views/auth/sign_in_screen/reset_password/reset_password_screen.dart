import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_in_screen/reset_password/reset_password_mobile_responsive.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ResetPasswordMobileResponsive());
  }
}
