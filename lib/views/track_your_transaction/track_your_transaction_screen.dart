import '../../utils/responsive_layout.dart';
import '../../views/track_your_transaction/track_your_transaction_mobile_responsive.dart';

import '../../utils/basic_screen_imports.dart';

class TrackYourTransactionScreen extends StatelessWidget {
  const TrackYourTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: TrackYourTransactionMobileResponsive());
  }
}


