import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/recipient_information/recipient_information_mobile_screen.dart';

class RecipientInformationScreen extends StatelessWidget {
  const RecipientInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: RecipientInformationMobileResponsive());
  }
}
