import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/money_transfer/money_transfer_mobile_responsive.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: MoneyTransferMobileResponsive());
  }
}
