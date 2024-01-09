import 'package:flutter/services.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../controller/payment_information/payment_information_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/others/custom_image_widget.dart';

class DownloadPdfScreen extends StatelessWidget {
  DownloadPdfScreen({super.key});
  final controller = Get.put(PaymentInformationController());
  @override
  Widget build(BuildContext context) {
    Future<bool> willPop() {
      Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: PrimaryAppBar(
          appBar: AppBar(),
          title: TitleHeading2Widget(
            text: Strings.paymentConfirmation,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          autoLeading: false,
          appbarColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          _imageWidget(context),
          _titleWidget(),
          verticalSpace(Dimensions.heightSize * 3),
          _copyLinkWidget(context),
          _downloadButton(context),
          _homeButton(context)
        ],
      ),
    );
  }

  _imageWidget(BuildContext context) {
    return CustomImageWidget(
      path: Assets.clipart.confirmationPng.path,
      width: MediaQuery.of(context).size.width * 0.59,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  _titleWidget() {
    return TitleHeading3Widget(
      text: Strings.yourPaymentIsSuccessfully,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w400,
    );
  }

  _downloadButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 0.8,
        bottom: Dimensions.marginSizeVertical * 0.5,
      ),
      child: Obx(
        () => controller.isDownloadLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.downloadReceiptPDF,
                onPressed: () {
                  controller.downloadPdf();
                },
              ),
      ),
    );
  }

  _homeButton(BuildContext context) {
    return PrimaryButton(
      title: Strings.goToDashboard,
      buttonColor: Colors.transparent,
      buttonTextColor: CustomColor.primaryDarkColor,
      onPressed: () {
        Get.offNamedUntil(Routes.bottomNavBar, (route) => false);
      },
    );
  }

  _copyLinkWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        border: Border.all(color: CustomColor.primaryLightTextColor),
      ),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Expanded(
            flex: 10,
            child: TitleHeading4Widget(
              text: controller.manualPaymentConfirmModel.data.shareLink,
              opacity: 0.30,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: const Icon(Icons.copy_outlined),
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                        text: controller
                            .manualPaymentConfirmModel.data.shareLink))
                    .then((value) {
                  CustomSnackBar.success(Strings.copyUrl);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
