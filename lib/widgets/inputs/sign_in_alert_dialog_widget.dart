import '/backend/utils/custom_loading_api.dart';
import '../../../widgets/inputs/text_input_field.dart';
import '../../controller/auth/sign_in/sign_in_screen_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../extensions/custom_extensions.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

class SignInAlertDialog extends StatelessWidget {
  SignInAlertDialog({
    super.key,
  });

  final SignInScreenController controller = Get.put(SignInScreenController());
  final formKey = GlobalKey<FormState>();

//alert dialog for forgot password
//this widget contains text, input field and a button
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.isDarkMode
          ? CustomColor.primaryDarkColor
          : CustomColor.alertDialogColor,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius)),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SingleChildScrollView(
            child: Container(
              width: width * 0.85,
              height: height * 0.45,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.paddingSize * .80,
                  right: Dimensions.paddingSize,
                  top: Dimensions.paddingSize * .80,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: CustomImageWidget(
                          path: Assets.icon.cross,
                          height: Dimensions.heightSize * 1.12,
                          width: Dimensions.widthSize * 1.33,
                        ),
                      ),
                    ),
                    // for clearing the alert dialog
                    verticalSpace(Dimensions.marginSizeVertical * 0.5),
                    TitleHeading2Widget(
                      text: Strings.forgotPassword2.tr,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize2 * 0.8,
                    ),
                    verticalSpace(Dimensions.marginSizeVertical * 0.3),
                    TitleHeading4Widget(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.headingTextSize4 * 0.84,
                      textAlign: TextAlign.center,
                      color: Get.isDarkMode
                          ? CustomColor.whiteColor
                          : CustomColor.customTextColor,
                      padding: EdgeInsets.only(
                        bottom: Dimensions.paddingSize * 0.4,
                      ),
                      text: Strings.enterRegisteredEmail.tr,
                    ),
                    Form(
                      key: formKey,
                      child: CustomTextInputField(
                        controller: controller.resetUserEmailController,
                        hintText: Strings.enterYourEmail.tr,
                        icon: Assets.icon.mail,
                        inputText: Strings.yourEmail.tr,
                      ),
                    ),
                    verticalSpace(Dimensions.marginSizeVertical * 0.6),
                    _forgotPassword(context),

                    // button for ongoing process
                  ],
                ),
              ),
            ),
          ).customGlassWidget();
        },
      ),
    );
  }

//forgot password button
  _forgotPassword(BuildContext context) {
    return Obx(
      () => controller.isForgotPasswordLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.forgotPasswordNormal.tr,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onForgotPassword;
                }
              },
              borderColor: CustomColor.primaryLightColor,
              buttonColor: CustomColor.primaryLightColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize2,
            ),
    );
  }
}
