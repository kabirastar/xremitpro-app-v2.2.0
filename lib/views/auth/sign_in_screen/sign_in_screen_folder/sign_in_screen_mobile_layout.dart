import '/backend/utils/custom_loading_api.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../controller/auth/biometric_controller/bio_metric_controller.dart';
import '../../../../controller/auth/sign_in/sign_in_screen_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../extensions/custom_extensions.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/back_button.dart';
import '../../../../widgets/inputs/password_input_field.dart';
import '../../../../widgets/inputs/sign_in_alert_dialog_widget.dart';
import '../../../../widgets/inputs/text_input_field.dart';
import '../../../../widgets/logo/basic_logo_widget.dart';

class SignInScreenMobileLayout extends StatelessWidget {
  SignInScreenMobileLayout({
    super.key,
  });

  final textColor = Get.isDarkMode
      ? CustomColor.primaryDarkTextColor
      : CustomColor.secondaryLightTextColor;
  final formKey = GlobalKey<FormState>();

  final SignInScreenController controller = Get.put(SignInScreenController());
  final biometric = Get.put(BiometricController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        action: [
          GestureDetector(
            onTap: () {
              controller.goToSignUpScreen();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
                color: CustomColor.primaryLightColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                child: TitleHeading2Widget(
                  text: Strings.signUp.tr,
                  color: CustomColor.whiteColor,
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
        ],
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.signIn,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

//this is sign in widget which contains a logo, text, email input field, password input field, forget password button
  // sign in button, continue button, or text, and share into social media buttons
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          children: [
            _imageWidget(context),
            _subHeadingTextWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 2),
            _signInFormField(context),
            _forgotPasswordButtonWidget(context),
            verticalSpace(Dimensions.marginSizeVertical),
            // SignInButton(),
            _signInButtonWidget(context),
            verticalSpace(Dimensions.marginSizeVertical),
          ],
        ),
      ),
    );
  }

//logo
  _imageWidget(BuildContext context) {
    return BasicLogoWidget(
      isWhite: Get.isDarkMode ? true : false,
    );
  }

//sub heading
  _subHeadingTextWidget(BuildContext context) {
    return TitleHeading3Widget(
      text: Strings.onboardSubtitleText.tr,
      fontWeight: FontWeight.w400,
      color: textColor,
      textAlign: TextAlign.center,
    );
  }

//sign in form with email and password
  _signInFormField(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextInputField(
            icon: Assets.icon.mail,
            inputText: Strings.yourEmail.tr,
            controller: controller.emailController,
            hintText: Strings.enterYourEmail.tr,
          ),
          CustomPasswordInputField(
            icon: Assets.icon.password,
            inputText: Strings.password.tr,
            controller: controller.passwordController,
            hintText: Strings.enterPassword.tr,
          ),
        ],
      ),
    );
  }

//forgot password button
  _forgotPasswordButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDialog(context);
      },
      child: TitleHeading4Widget(
        padding: EdgeInsets.only(left: Dimensions.paddingSize * 7.6),
        text: Strings.forgotPassword.tr,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode
            ? CustomColor.primaryDarkTextColor
            : CustomColor.primaryLightColor,
      ),
    );
  }

//forgot password alert dialog
  _openDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => SignInAlertDialog().customGlassWidget(blurX: 1, blurY: 1),
    );
  }

  //sign in button
  _signInButtonWidget(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : PrimaryButton(
                  title: Strings.signIn.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize2 * 0.9,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.onSignIn;
                    }
                  },
                  borderColor: CustomColor.primaryLightColor,
                  buttonColor: CustomColor.primaryLightColor,
                  buttonTextColor: CustomColor.whiteColor,
                ),
        ),
        verticalSpace(Dimensions.heightSize * 1.5),
        Visibility(
          visible: biometric.supportState == SupportState.supported &&
              LocalStorage.isLoggedIn(),
          child: PrimaryButton(
            title: Strings.signInWithTouchId,
            onPressed: () async {
              bool isAuthenticated =
                  await Authentication.authenticateWithBiometrics();

              if (isAuthenticated) {
                Get.offAndToNamed(Routes.bottomNavBar);
              } else {
                debugPrint('isAuthenticated : false');
              }
            },
            buttonTextColor: CustomColor.primaryLightColor,
            buttonColor: Colors.transparent,
            borderColor: CustomColor.primaryLightColor,
            borderWidth: 1.5,
          ),
        ),
      ],
    );
  }
}
