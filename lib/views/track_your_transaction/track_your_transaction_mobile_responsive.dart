import '../../backend/utils/custom_loading_api.dart';
import '../../controller/track_your_transaction/track_your_transactions_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';
import '../../widgets/inputs/Input_field.dart';
import '../../widgets/transfer_log/transfer_log_card.dart';

class TrackYourTransactionMobileResponsive extends StatelessWidget {
  TrackYourTransactionMobileResponsive({
    super.key,
  });

  final controller = Get.put(TrackYourTransactionController());
  final languageController = Get.put(LanguageController());

  final textColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.secondaryLightTextColor;
  final blackWhiteColor =
      Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(
          centerTitle: true,
        ),
        title: TitleHeading2Widget(
          text: Strings.trackYourTransaction.tr,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        appbarSize: Dimensions.appBarHeight * 0.8,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.foundChapter.value.isEmpty
        ? controller.transactionInfoModel.data.transaction
        : controller.foundChapter.value;
    return Column(
      mainAxisAlignment: controller.foundChapter.value.isEmpty
          ? MainAxisAlignment.center
          : mainStart,
      children: [
        Visibility(
          visible: controller.transactionInfoModel.data.transaction.isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
            ),
            child: InputField(
              hintText: languageController.getTranslation(Strings.enterMTCN),
              onFieldSubmitted: (v) {
                controller.filterTransaction(v);
              },
            ),
          ),
        ),
        RefreshIndicator(
          color: CustomColor.primaryLightColor,
          onRefresh: () async {
            controller.getAllTransactionApiProcess();
          },
          child: data.isEmpty
              ? Center(
                  child: TitleHeading2Widget(
                    text: Strings.noTransaction,
                    color: CustomColor.primaryLightColor,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: Dimensions.paddingSize * 0.7,
                      right: Dimensions.paddingSize * 0.7,
                      top: Dimensions.paddingSize * 0.5,
                    ),
                    children: List.generate(
                      data.length,
                      (index) => TransferLogCard(data: data[index]),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
