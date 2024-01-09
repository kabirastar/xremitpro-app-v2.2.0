import '../../../utils/basic_widget_imports.dart';
import '/utils/responsive_layout.dart';
import 'beneficiaries_mobile_screen_layout.dart';

class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: BeneficiariesMobileScreenLayout(),
    );
  }
}
