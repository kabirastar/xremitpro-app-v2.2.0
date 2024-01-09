import 'package:xremitpro/backend/utils/custom_snackbar.dart';

import '../../../widgets/inputs/text_input_field.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../extensions/custom_extensions.dart';
import '../../utils/basic_screen_imports.dart';
import '../others/custom_image_widget.dart';

class ApplyCouponDialog extends StatelessWidget {
  ApplyCouponDialog({
    super.key,
  });

  final controller = Get.put(DashboardController());
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
          var width = MediaQuery.of(context).size.width;
          return Container(
            width: width * 0.85,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * .80,
                right: Dimensions.paddingSize,
                top: Dimensions.paddingSize * .80,
              ),
              child: Column(
                mainAxisSize: mainMin,
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
                    text: Strings.applyCoupon.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize2,
                  ),
                  verticalSpace(Dimensions.marginSizeVertical),
                  CustomTextInputField(
                    controller: controller.couponController,
                    hintText: Strings.coupon.tr,
                    icon: Assets.icon.mail,
                    inputText: Strings.enterTheCouponCode.tr,
                  ),
                  verticalSpace(Dimensions.marginSizeVertical * 0.6),
                  _applyButton(context),
                  verticalSpace(Dimensions.marginSizeVertical * 0.6),
                ],
              ),
            ),
          ).customGlassWidget();
        },
      ),
    );
  }

//forgot password button
  _applyButton(BuildContext context) {
    return PrimaryButton(
      title: Strings.apply.tr,
      onPressed: () {
        if (controller.couponController.text.isNotEmpty) {
          Get.back();
          LocalStorage.saveCoupon(type: controller.couponController.text);
          controller.sendRemittanceProcess().then(
                (value) => controller.couponController.clear(),
              );
        } else {
          CustomSnackBar.error(Strings.pleaseFillOutTheField);
        }
      },
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightColor,
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.headingTextSize2,
    );
  }
}
