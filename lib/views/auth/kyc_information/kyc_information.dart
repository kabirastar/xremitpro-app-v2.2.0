import '/utils/basic_screen_imports.dart';
import '/utils/responsive_layout.dart';
import '/views/auth/kyc_information/kyc_information_mobile.dart';

class KycInformationScreen extends StatelessWidget {
  const KycInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: KycInformationMobileResponsive());
  }
}
