import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/two_fa/two_fa_otp_verification_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class TwoFaVerificationMobileScreenLayout extends StatelessWidget {
  const TwoFaVerificationMobileScreenLayout({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TwoFaOtpVerificationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.otpVerification.tr,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossCenter,
      mainAxisAlignment: mainCenter,
      children: [
        verticalSpace(Dimensions.heightSize * 2),
        _otpWidget(context),
      ],
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: () {
                  controller.onSubmit;
                },
              ),
      ),
    );
  }

  _otpWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          const TitleSubTitleWidget(
            title: Strings.twoFactorAuthorization,
            subTitle: Strings.enterTheTwoFaVerification,
            isCenterText: true,
          ),
          _otpInputWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: PinCodeTextField(
        appContext: context,
        backgroundColor: Colors.transparent,
        textStyle: TextStyle(
          color: CustomColor.primaryLightColor,
        ),
        pastedTextStyle: TextStyle(
          color: Colors.orange.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        validator: (String? value) {
          if (value!.isEmpty) {
            return Strings.pleaseFillOutTheField;
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          borderWidth: Dimensions.widthSize * 0.2,
          shape: PinCodeFieldShape.box,
          fieldHeight: 46,
          fieldWidth: 47,
          activeFillColor: Colors.transparent,
          inactiveColor: CustomColor.primaryLightColor,
          activeColor: CustomColor.primaryLightColor,
          selectedColor: CustomColor.primaryLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        cursorColor: Get.isDarkMode
            ? CustomColor.whiteColor
            : CustomColor.secondaryDarkColor,
        animationDuration: const Duration(milliseconds: 300),
        errorAnimationController: controller.errorController,
        controller: controller.pinCodeController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {},
        onChanged: (value) {
          controller.changeCurrentText(value);
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
