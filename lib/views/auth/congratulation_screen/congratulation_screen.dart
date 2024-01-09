import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import '../../../views/auth/congratulation_screen/congratulation_screen_mobile_responsive.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: CongratulationScreenMobileResponsive());
  }
}
