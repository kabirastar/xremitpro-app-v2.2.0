import 'package:xremitpro/controller/two_fa/two_fa_controller.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class TwoFAVerificationMobile extends StatelessWidget {
  TwoFAVerificationMobile({Key? key}) : super(key: key);
  final controller = Get.put(TwoFaVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.twoFASecurity.tr,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        _qrCodeWidget(context),
        _titleSubTitleWidget(context),
        _enableButtonWidget(context),
      ],
    ).paddingSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.8);
  }

  _enableButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isSubmitLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: controller.status.value == 0
                    ? Strings.enable
                    : Strings.disable,
                onPressed: () {
                  controller.onEnableOrDisable;
                },
              ),
      ),
    );
  }

  _titleSubTitleWidget(BuildContext context) {
    return TitleSubTitleWidget(
      title: Strings.enable2faSecurity,
      subTitle: controller.alert.value,
      isCenterText: true,
      subTitleFontSize: Dimensions.headingTextSize4 * 0.9,
    );
  }

  _qrCodeWidget(BuildContext context) {
    return Image.network(
      controller.qrCode.value,
      scale: 1.2,
    ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.5);
  }
}
