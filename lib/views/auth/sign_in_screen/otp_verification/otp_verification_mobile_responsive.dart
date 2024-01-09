import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/sign_in_otp_verification/otp_verification_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/back_button.dart';
import '../../../../widgets/inputs/otp_input_widget.dart';

class OtpVerificationMobileResponsive extends StatelessWidget {
  OtpVerificationMobileResponsive({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignInOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.signInScreen);
        return true;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          leading: BackButtonWidget(
            onTap: () {
              Get.offAllNamed(Routes.signInScreen);
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
            verticalSpace(Dimensions.marginSizeVertical * 1.8),
            _customTitleWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 0.3),
            _customSubTitleWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 2),
            _otpInputWidget(context),
            _timeWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 1.5),
            _submitButtonWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 0.8),
            _resendButtonWidget(context),
          ],
        ),
      ),
    );
  }

  //verification code text
  _customTitleWidget(context) {
    return TitleHeading1Widget(
      fontWeight: FontWeight.w600,
      text: Strings.verificationCode.tr,
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.75),
    );
  }

  //description text
  _customSubTitleWidget(BuildContext context) {
    return TitleHeading3Widget(
      text: Strings.enterTheVerificationCode.tr,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w400,
    );
  }

// widget for input otp code
  _otpInputWidget(BuildContext context) {
    return OTPInputWidget(formKey: formKey, controller: controller);
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
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.radius),
              ),
            ),
            title: Strings.submit.tr,
            fontSize: Dimensions.headingTextSize2,
            buttonTextColor: CustomColor.whiteColor,
            onPressed: () {
              {
                if (formKey.currentState!.validate()) {
                  controller.onOtpVerify;
                }
              }
            },
            borderColor: CustomColor.primaryLightColor,
            buttonColor: CustomColor.primaryLightColor,
          ));
  }

//resend button
  _resendButtonWidget(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.enableResend.value,
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
    );
  }
}
