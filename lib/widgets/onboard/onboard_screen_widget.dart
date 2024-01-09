import '/controller/onboard/onboard_screen_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

//this widget contains onboard image, moving icon, heading text, description, three buttons and sign up button
class OnboardScreenWidget extends StatelessWidget {
  OnboardScreenWidget({
    Key? key,
  }) : super(key: key);

  final buttonBackGroundColor = Get.isDarkMode
      ? Colors.transparent
      : CustomColor.primaryLightColor.withOpacity(0.05);
  final whiteBlackColor = CustomColor.stateColor;
  final OnboardScreenController controller = Get.put(OnboardScreenController());

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize,
        right: Dimensions.paddingSize,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          verticalSpace(Dimensions.heightSize * 3.33),
          _onboardButtonTrackWidget(context, Strings.trackYourTransaction.tr),
          verticalSpace(Dimensions.paddingSize * 0.5),
          // _onboardButtonTransferCalculatorWidget(
          //     context, Strings.transferCalculator.tr),
          // verticalSpace(Dimensions.paddingSize * 0.5),
          _signInButtonWidget(context),
          verticalSpace(Dimensions.paddingSize * 1.33),
          _textWidget(context),
          verticalSpace(Dimensions.paddingSize * 0.2),
        ],
      ),
    );
  }

  _onboardButtonTrackWidget(BuildContext context, String buttonText) {
    final String text = buttonText;
    return PrimaryButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.radius,
          ),
        ),
        fontWeight: FontWeight.w600,
        buttonTextColor: Get.isDarkMode
            ? CustomColor.secondaryDarkTextColor
            : CustomColor.secondaryLightTextColor,
        borderWidth: 1.2,
        title: text,
        fontSize: Dimensions.headingTextSize2 * 0.9,
        onPressed: () {
          controller.goToTrackYourTransactionScreen();
        },
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor.withOpacity(0.3),
        buttonColor: buttonBackGroundColor);
  }

  _onboardButtonTransferCalculatorWidget(
      BuildContext context, String buttonText) {
    final String text = buttonText;
    return PrimaryButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.radius,
          ),
        ),
        fontWeight: FontWeight.w600,
        buttonTextColor: Get.isDarkMode
            ? CustomColor.secondaryDarkTextColor
            : CustomColor.secondaryLightTextColor,
        borderWidth: 1.2,
        title: text,
        fontSize: Dimensions.headingTextSize2 * 0.9,
        onPressed: () {
          controller.goToTransferCalculator();
        },
        borderColor: Get.isDarkMode
            ? CustomColor.primaryDarkColor
            : CustomColor.primaryLightColor.withOpacity(0.3),
        buttonColor: buttonBackGroundColor);
  }

  _signInButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.signIn.tr,
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.headingTextSize2 * 0.9,
      onPressed: () {
        controller.goToSignIn();
      },
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightColor,
      buttonTextColor: CustomColor.whiteColor,
    );
  }

  _textWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleHeading5Widget(
          text: Strings.newUserHere.tr,
          color: whiteBlackColor,
          fontWeight: FontWeight.w400,
        ),
        horizontalSpace(Dimensions.widthSize * 0.3),
        GestureDetector(
          onTap: () {
            controller.goToSignUp();
          },
          child: TitleHeading5Widget(
            text: Strings.signUp.tr,
            color: Get.isDarkMode
                ? CustomColor.secondaryDarkTextColor
                : CustomColor.secondaryLightTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ).paddingOnly(bottom: Dimensions.heightSize);
  }
}
