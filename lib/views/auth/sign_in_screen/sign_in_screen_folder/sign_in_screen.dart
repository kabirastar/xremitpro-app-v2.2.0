import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import 'sign_in_screen_mobile_layout.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: SignInScreenMobileLayout());
  }
}
