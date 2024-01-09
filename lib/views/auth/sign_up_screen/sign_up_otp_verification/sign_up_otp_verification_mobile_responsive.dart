import '/backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_up/sign_up_otp_verification/sign_up_otp_verification_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/back_button.dart';
import '../../../../widgets/inputs/sign_up_otp_input_widget.dart';

class SignUpOtpVerificationMobileResponsive extends StatelessWidget {
  SignUpOtpVerificationMobileResponsive({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        appbarSize: Dimensions.appBarHeight * 0.7,
        title: TitleHeading2Widget(
          text: Strings.oTPVerification.tr,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(context),
      ),
    );
  }

// shows everything of otp verification screen
  // image, pin code field for otp, timer, resend button, submit button
  _bodyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          children: [
            _customTitleWidget(context),
            _customSubTitleWidget(context),
            _otpInputWidget(context),
            _timeWidget(context),
            _submitButtonWidget(context),
            _resendButtonWidget(context),
          ],
        ),
      ),
    );
  }

  //verification code text
  _customTitleWidget(context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.8),
      child: TitleHeading1Widget(
        fontWeight: FontWeight.w600,
        text: Strings.verificationCode.tr,
        padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.75),
      ),
    );
  }

  //description text
  _customSubTitleWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.3),
      child: TitleHeading3Widget(
        text: Strings.enterTheVerificationCode.tr,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w400,
      ),
    );
  }

// widget for input otp code
  _otpInputWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 2),
      child: SignUpOtpInputWidget(formKey: formKey, controller: controller),
    );
  }

  //showing timer
  _timeWidget(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.paddingSize,
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            const Icon(
              Icons.watch_later_sharp,
              color: CustomColor.secondaryDarkTextColor,
            ),
            horizontalSpace(Dimensions.widthSize),
            Text(
                '0${controller.minuteRemaining.value}:${controller.secondsRemaining.value}',
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading3TextStyle.copyWith(
                        color: CustomColor.primaryLightColor,
                        fontWeight: FontWeight.w600)
                    : CustomStyle.lightHeading3TextStyle.copyWith(
                        color: CustomColor.primaryLightColor,
                        fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  //submit otp code button
  _submitButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.5),
              child: PrimaryButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius),
                  ),
                ),
                title: Strings.submit.tr,
                fontSize: Dimensions.headingTextSize2,
                buttonTextColor: Get.isDarkMode
                    ? CustomColor.blackColor
                    : CustomColor.whiteColor,
                onPressed: () {
                  {
                    if (formKey.currentState!.validate()) {
                      controller.onSubmit;
                    }
                  }
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
            ),
    );
  }

//resend button
  _resendButtonWidget(BuildContext context) {
    return Obx(() => Visibility(
          visible: controller.enableResend.value,
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.paddingSize * .8),
            child: GestureDetector(
              onTap: () {
                controller.resendCode();
              },
              child: TitleHeading3Widget(
                text: Strings.resendCode.tr,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ));
  }
}
