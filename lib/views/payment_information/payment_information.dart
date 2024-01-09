import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/payment_information/payment_information_mobile_responsive.dart';

class PaymentInformationScreen extends StatelessWidget {
  const PaymentInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: PaymentInformationMobileResponsive());
  }
}
