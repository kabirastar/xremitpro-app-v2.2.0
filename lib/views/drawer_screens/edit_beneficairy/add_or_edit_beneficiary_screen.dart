import 'package:xremitpro/utils/basic_screen_imports.dart';

import '../../../controller/drawer/edit_or_add_beneficiary_controller.dart';
import '../../../utils/responsive_layout.dart';
import 'add_or_edit_beneficiairy_mobile_screen.dart';

class AddOrEditBeneficiaryScreen extends StatelessWidget {
  AddOrEditBeneficiaryScreen({super.key});
  final controller = Get.put(EditOrAddBeneficiaryController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: AddOrEditBeneficiaryMobileScreen(controller: controller),
    );
  }
}
