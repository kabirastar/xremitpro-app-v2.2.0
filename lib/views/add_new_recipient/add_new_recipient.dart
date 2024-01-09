import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';
import '../../views/add_new_recipient/add_new_recipient_mobile_responsive.dart';

class AddNewRecipientScreen extends StatelessWidget {
  const AddNewRecipientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: AddNewRecipientMobileResponsive());
  }
}
