import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/payment_preview/payment_preview_mobile_responsive.dart';

class PaymentPreview extends StatelessWidget {
  const PaymentPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: PaymentPreviewMobileResponsive());
  }
}
