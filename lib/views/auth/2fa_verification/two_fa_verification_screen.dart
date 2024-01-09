import '../../../controller/two_fa/two_fa_otp_verification_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import 'two_fa_verification_mobile_screen_layout.dart';

class TwoFaOtpVerificationScreen extends StatelessWidget {
  TwoFaOtpVerificationScreen({Key? key}) : super(key: key);
  final controller = Get.put(TwoFaOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TwoFaVerificationMobileScreenLayout(
        controller: controller,
      ),
    );
  }
}
