import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/transfer_calculator/transfer_calculator_mobile_responsive.dart';

class TransferCalculatorScreen extends StatelessWidget {
  const TransferCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: TransferCalculatorScreenMobileResponsive());
  }
}
