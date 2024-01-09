import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_in_screen/otp_verification/otp_verification_mobile_responsive.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: OtpVerificationMobileResponsive());
  }
}
