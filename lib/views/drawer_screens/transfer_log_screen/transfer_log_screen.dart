import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../views/drawer_screens/transfer_log_screen/transfer_log_mobile_responsive.dart';

class TransferLogScreen extends StatelessWidget {
  const TransferLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TransferLogScreenMobileResponsive(),
    );
  }
}
