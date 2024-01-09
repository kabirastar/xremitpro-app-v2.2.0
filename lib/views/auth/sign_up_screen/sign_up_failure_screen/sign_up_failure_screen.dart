import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_up_screen/sign_up_failure_screen/sign_up_failure_screen_mobile.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileScaffold: SignUpFailureScreen());
  }
}
