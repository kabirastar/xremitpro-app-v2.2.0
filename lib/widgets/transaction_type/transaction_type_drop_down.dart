import 'package:xremitpro/controller/dashboard/dashboard_controller.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';

import '../drop_down/custom_input_drop_down_new.dart';

class TransactionTypeDropDown extends StatelessWidget {
  TransactionTypeDropDown({super.key, this.isMain = false});
  final controller = Get.put(DashboardController());
  final bool isMain;
  @override
  Widget build(BuildContext context) {
    return CustomInputDropDownNewWidget(
      text: Strings.receiveMethod.tr,
      isMain: isMain,
      onChanged: (v) {
        controller.selectTransactionType.value = v!;
        controller.featureText.value = controller.featureTextList[controller
            .transactionTypeList
            .indexOf(controller.selectTransactionType.value)];
        controller.sendRemittanceProcess();
      },
      itemsList: controller.transactionTypeList,
      selectMethod: controller.selectTransactionType,
    );
  }
}
