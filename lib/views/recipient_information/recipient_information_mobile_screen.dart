import '../../controller/recipient_information/recipient_information_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../model/recipient_information_model.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';
import '../../widgets/others/custom_image_widget.dart';
import '../../widgets/recipient_information/recipient_information_card_widget.dart';
import '../../widgets/recipient_information/recipient_information_input_field.dart';

class RecipientInformationMobileResponsive extends StatelessWidget {
  RecipientInformationMobileResponsive({
    super.key,
  });

  final RecipientInformationController controller =
      Get.put(RecipientInformationController());
  final customColor = Get.isDarkMode
      ? CustomColor.primaryDarkTextColor
      : CustomColor.primaryLightTextColor;
  final secondaryCustomColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.secondaryLightTextColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(text: Strings.recipientInformation.tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: false,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 10),
        ),
        onPressed: () {
          controller.goToAddNewRecipientScreen();
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: CustomImageWidget(
          path: Assets.icon.add,
          height: Dimensions.heightSize * 6.34,
          width: Dimensions.widthSize * 7.65,
        ),
      ),
    );
  }

// this widget contains input text, saved recipient text, list of recipients
  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize,
        right: Dimensions.paddingSize,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _inputFieldWidget(context),
          _textWidget(context),
          _listOfSavedRecipientWidget(context),
        ],
      ),
    );
  }

// text input field
  _inputFieldWidget(BuildContext context) {
    return RecipientInformationInputField(
      controller: controller.enterEmailOrUsername,
      hintText: Strings.enterGmailOrUsername.tr,
    );
  }

// saved recipient
  _textWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingSize, bottom: Dimensions.paddingSize * 0.333),
      child: TitleHeading2Widget(
        text: Strings.savedRecipients.tr,
        fontWeight: FontWeight.w500,
        fontSize: Dimensions.headingTextSize2 * 0.9,
        color: customColor.withOpacity(.40),
      ),
    );
  }

  //list of recipients
  _listOfSavedRecipientWidget(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: onRecipientPages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.goToPaymentInformation();
            },
            child: RecipientInformationCardWidget(
              secondaryCustomColor: secondaryCustomColor,
              text: onRecipientPages[index].title,
              subText: onRecipientPages[index].subTitle,
              onEdit: () {},
              onDelete: () {},
              beneficiaries: null,
            ),
          );
        },
      ),
    );
  }
}
