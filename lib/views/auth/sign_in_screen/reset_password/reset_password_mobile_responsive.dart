import '/backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/reset_password_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_field.dart';

class ResetPasswordMobileResponsive extends StatelessWidget {
  ResetPasswordMobileResponsive({
    super.key,
  });

  final controller = Get.put(ResetPasswordController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.signInScreen);
        return true;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          title: TitleHeading2Widget(
              text: Strings.resetPassword.tr, fontWeight: FontWeight.w600),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          autoLeading: true,
          appbarColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

//this widget contains two password field and a button
  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: Column(
        children: [
          _passwordFieldWidget(context),
          verticalSpace(Dimensions.marginSizeVertical * 1.2),
          _resetPasswordButtonWidget(context),
        ],
      ),
    );
  }

// new and confirm password
  _passwordFieldWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomPasswordInputField(
            controller: controller.newPasswordController,
            hintText: Strings.enterNewPassword.tr,
            icon: Assets.icon.password,
            inputText: Strings.newPassword.tr,
          ),
          CustomPasswordInputField(
            controller: controller.confirmPasswordController,
            hintText: Strings.enterConfirmPassword.tr,
            icon: Assets.icon.password,
            inputText: Strings.confirmPassword.tr,
          ),
        ],
      ),
    );
  }

//reset password button
  _resetPasswordButtonWidget(BuildContext context) {
    return Obx(() => controller.isLoading
        ? const CustomLoadingAPI()
        : PrimaryButton(
            title: Strings.resetPassword.tr,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.onResetPassword;
              }
            },
            borderColor: CustomColor.primaryLightColor,
            buttonColor: CustomColor.primaryLightColor,
            fontSize: Dimensions.headingTextSize2,
            fontWeight: FontWeight.w600,
          ));
  }
}
