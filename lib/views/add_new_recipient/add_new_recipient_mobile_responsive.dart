import '../../controller/add_new_recipient/add_new_recipient_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';

class AddNewRecipientMobileResponsive extends StatelessWidget {
  AddNewRecipientMobileResponsive({Key? key}) : super(key: key);
  final BankTransferController controller = Get.put(BankTransferController());
  final textColor = Get.isDarkMode
      ? CustomColor.primaryDarkTextColor
      : CustomColor.primaryLightTextColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        appbarSize: Dimensions.appBarHeight * 0.8,
        title: TitleHeading2Widget(
          text: Strings.recipientDetails.tr,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: false,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

// this widget contains a drop down button
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.75,
          right: Dimensions.paddingSize * 0.75,
        ),
        child: const Column(
          children: [
            // _transactionTypeWidget(context),
            // _bankTransferWidget(context),
            // _cashPickupWidget(context),
            // _mobileMoneyWidget(context),
          ],
        ),
      ),
    );
  }

}
