import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/password_input_field.dart';
import '../../../controller/drawer/change_password_controller.dart';
import '../../../widgets/appbar/back_button.dart';

class ChangePasswordMobileResponsive extends StatelessWidget {
  ChangePasswordMobileResponsive({
    super.key,
  });

  final ChangePasswordController controller =
      Get.put(ChangePasswordController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(
            text: Strings.changePassword.tr, fontWeight: FontWeight.w600),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

//this widget contains two password field and a button
  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _passwordFieldWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 1.2),
            _resetPasswordButtonWidget(context),
          ],
        ),
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
            controller: controller.oldPasswordController,
            hintText: Strings.enterPassword.tr,
            icon: Assets.icon.password,
            inputText: Strings.oldPassword.tr,
          ),
          CustomPasswordInputField(
            controller: controller.newPasswordController,
            hintText: Strings.enterPassword.tr,
            icon: Assets.icon.password,
            inputText: Strings.newPassword.tr,
          ),
          CustomPasswordInputField(
            controller: controller.confirmPasswordController,
            hintText: Strings.enterPassword.tr,
            icon: Assets.icon.password,
            inputText: Strings.confirmPassword.tr,
          ),
        ],
      ),
    );
  }

//reset password button
  _resetPasswordButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.changePassword.tr,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onChangePassword;
                }
              },
              borderColor: CustomColor.primaryLightColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
    );
  }
}
