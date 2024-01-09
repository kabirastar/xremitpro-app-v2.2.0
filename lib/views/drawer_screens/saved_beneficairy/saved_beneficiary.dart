import '../../../utils/basic_screen_imports.dart';
import '../../../utils/responsive_layout.dart';
import 'saved_beneficairy_mobile_responsive.dart';

class SavedBeneficiaryScreen extends StatelessWidget {
  const SavedBeneficiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: SavedBeneficiaryMobileResponsive());
  }
}
