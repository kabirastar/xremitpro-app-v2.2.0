import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '../../../controller/track_your_transaction/track_your_transactions_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/transfer_log/transfer_log_card.dart';

class TransferLogScreenMobileResponsive extends StatelessWidget {
  TransferLogScreenMobileResponsive({
    super.key,
  });

  final controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return RefreshIndicator(
      color: CustomColor.primaryLightColor,
      onRefresh: () async {
        controller.getTransactionApiProcess();
      },
      child: controller.transactionInfoModel.data.transaction.isEmpty
          ? Center(
              child: TitleHeading2Widget(
                text: Strings.noTransaction,
                color: CustomColor.primaryLightColor,
                fontSize: Dimensions.headingTextSize2 * 0.8,
                opacity: 0.8,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.7,
                right: Dimensions.paddingSize * 0.7,
                top: Dimensions.paddingSize * 1.136,
              ),
              itemCount:
                  controller.transactionInfoModel.data.transaction.length,
              itemBuilder: (BuildContext context, int index) {
                var data =
                    controller.transactionInfoModel.data.transaction[index];
                return TransferLogCard(data: data);
              },
            ),
    );
  }
}
