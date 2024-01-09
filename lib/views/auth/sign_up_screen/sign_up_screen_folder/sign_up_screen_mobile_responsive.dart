import 'package:google_fonts/google_fonts.dart';
import 'package:xremitpro/views/flutter_web/flutter_wab_screen.dart';
import 'package:xremitpro/widgets/logo/basic_logo_widget.dart';

import '/backend/utils/custom_loading_api.dart';
import '../../../../backend/services/api_endpoint.dart';
import '../../../../backend/utils/custom_snackbar.dart';
import '../../../../controller/auth/sign_up/sign_up_screen_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../language/language_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/appbar/back_button.dart';
import '../../../../widgets/inputs/password_input_field.dart';
import '../../../../widgets/inputs/text_input_field.dart';

class SignUpScreenMobileResponsive extends StatelessWidget {
  SignUpScreenMobileResponsive({
    super.key,
  });

  final SignUpController controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appbarSize: Dimensions.appBarHeight * 0.8,
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        action: [
          GestureDetector(
            onTap: () {
              controller.goToSignInScreen();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                color: CustomColor.primaryLightColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                child: TitleHeading2Widget(
                  text: Strings.signIn.tr,
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
          text: Strings.signUp.tr,
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

  // this widget contains sign up form fields, terms and condition, sign up button, sign in with button social media
  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _logoWidgetAndTitleWidget(context),
            verticalSpace(Dimensions.heightSize * 4 - 2),
            _signUpFormWidget(context),
            _termsAndConditionWidget(context),
            _signUpButtonWidget(context),
          ],
        ),
      ),
    );
  }

// sign up form text input form field
  _signUpFormWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _enterNameWidget(context),
          _enterEmailWidget(context),
          _passwordWidget(context),
        ],
      ),
    );
  }

//first and last name
  _enterNameWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.44,
          child: CustomTextInputField(
            controller: controller.firstNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.user,
            inputText: Strings.firstName.tr,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: CustomTextInputField(
            controller: controller.lastNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.user,
            inputText: Strings.lastName.tr,
          ),
        ),
      ],
    );
  }

//email
  _enterEmailWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.emailController,
      hintText: Strings.enterYourEmail.tr,
      icon: Assets.icon.mail,
      inputText: Strings.yourEmail.tr,
    );
  }

//password input field
  _passwordWidget(BuildContext context) {
    return CustomPasswordInputField(
      controller: controller.passwordController,
      hintText: Strings.password.tr,
      icon: Assets.icon.password,
      inputText: Strings.enterPassword.tr,
    );
  }

  //terms and condition
  _termsAndConditionWidget(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Padding(
            padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.2),
            child: SizedBox(
              height: 24.0.h,
              width: 24.0.w,
              child: Checkbox(
                value: controller.agreed.value,
                onChanged: (value) {
                  controller.agreed.value = value!;
                },
                activeColor: CustomColor.primaryLightColor,
                checkColor: controller.agreed.value
                    ? Theme.of(context).colorScheme.background
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.2),
                ),
                side: BorderSide(
                  width: 2,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                      : CustomColor.primaryLightTextColor.withOpacity(0.30),
                ),
              ),
            ),
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.to(
                () => FlutterWebScreen(
                  title: Strings.privacyAndPolicy,
                  paymentUrl: '${ApiEndpoint.mainDomain}/link/privacy-policy',
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.2),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        color: CustomColor.blackColor,
                        decoration: TextDecoration.none,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: languageController.getTranslation(Strings.iAgree),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          color: Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                              : CustomColor.deepGray,
                          fontSize: Dimensions.headingTextSize4),
                    ),
                    TextSpan(
                      text: languageController
                          .getTranslation(Strings.termsAndCondition),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: CustomColor.primaryLightColor,
                          fontSize: Dimensions.headingTextSize4),
                    ),
                    TextSpan(
                      text: languageController.getTranslation(Strings.and),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                              : CustomColor.deepGray,
                          fontSize: Dimensions.headingTextSize4),
                    ),
                    TextSpan(
                      text: languageController
                          .getTranslation(Strings.privacyAndPolicy),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: CustomColor.primaryLightColor,
                          fontSize: Dimensions.headingTextSize4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  //sign up button
  _signUpButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.67),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.signUp.tr,
                fontSize: Dimensions.headingTextSize2,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.agreed.value) {
                      controller.onSignUp;
                    } else {
                      CustomSnackBar.error(Strings.pleaseAgree);
                    }
                  }
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }

  //logo and title widget
  _logoWidgetAndTitleWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        BasicLogoWidget(
          isWhite: Get.isDarkMode ? true : false,
        ),
        verticalSpace(Dimensions.heightSize * 0.91),
        TitleHeading3Widget(
          text: Strings.titleSignUp.tr,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
