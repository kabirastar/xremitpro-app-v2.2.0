import '/utils/basic_screen_imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../controller/auth/sign_up/sign_up_otp_verification/sign_up_otp_verification_controller.dart';

class SignUpOtpInputWidget extends StatelessWidget {
  const SignUpOtpInputWidget({
    super.key,
    required this.formKey,
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final SignUpOtpVerificationController controller;

  // final CustomColor.primaryLightColor =
  //     Get.isDarkMode ? CustomColor.whiteColor : CustomColor.primaryBGDarkColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      child: Form(
        key: formKey,
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
          validator: (v) {
            if (v!.length < 3) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            borderWidth: Dimensions.widthSize * 0.2,
            shape: PinCodeFieldShape.box,
            fieldHeight: 46.h,
            fieldWidth: 48.w,
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
      ),
    );
  }
}
