import '../../../../../utils/responsive_layout.dart';
import '../../../../utils/basic_screen_imports.dart';
import 'sign_up_screen_mobile_responsive.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: SignUpScreenMobileResponsive());
  }
}
