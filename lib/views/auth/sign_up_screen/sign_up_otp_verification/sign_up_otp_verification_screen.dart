import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_up_screen/sign_up_otp_verification/sign_up_otp_verification_mobile_responsive.dart';

class SignUpOtpVerificationScreen extends StatelessWidget {
  const SignUpOtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: SignUpOtpVerificationMobileResponsive());
  }
}
