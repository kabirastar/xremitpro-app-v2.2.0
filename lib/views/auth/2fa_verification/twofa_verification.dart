import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import 'twofa_verification_mobile.dart';

class TwoFAVerificationScreen extends StatelessWidget {
  const TwoFAVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: TwoFAVerificationMobile());
  }
}
