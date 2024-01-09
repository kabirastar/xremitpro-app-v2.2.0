import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '/widgets/appbar/back_button.dart';
import '../../controller/payment_information/payment_information_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/buttons/animated_button.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class PaymentPreviewMobileResponsive extends StatelessWidget {
  PaymentPreviewMobileResponsive({
    super.key,
  });

  final customColor =
      Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor;
  final customTextColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.primaryLightTextColor;
  final controller = Get.put(PaymentInformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.paymentPreview.tr,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        autoLeading: true,
        appbarColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

// all account information, recipient information, payment information
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _amountInformationCardWidget(context),
          verticalSpace(Dimensions.heightSize * 0.67),
          _recipientInformationWidget(context),
          verticalSpace(Dimensions.heightSize * 0.67),
          _paymentInformationWidget(context),
          verticalSpace(Dimensions.heightSize * 2.667),
          _paymentButtonWidget(context),
        ],
      ),
    );
  }

  // all amount transactions information
  _amountInformationCardWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * 0.7,
        right: Dimensions.paddingSize * 0.7,
        top: Dimensions.paddingSize * 0.25,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius * 1.25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.paddingSize * 0.5,
              right: Dimensions.paddingSize * 0.5),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              verticalSpace(Dimensions.heightSize * 1.33),
              TitleHeading3Widget(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.375),
                text: Strings.remittanceSummary.tr,
                fontWeight: FontWeight.w600,
                color: customTextColor,
              ),
              verticalSpace(Dimensions.heightSize * 2),
              _lineWidget(context),
              _accountInformationWidget(context),
              verticalSpace(Dimensions.heightSize * 1.12),
            ],
          ),
        ),
      ),
    );
  }

// make a border line
  _lineWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: customTextColor.withOpacity(0.10),
          width: 0.5,
        ),
      ),
    );
  }

// all information of account
  _accountInformationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.375,
          right: Dimensions.paddingSize * 0.375),
      child: Column(
        children: [
          _customInfoWidget(
            context,
            text1: Strings.sendingAmount.tr,
            text2: controller.sendingAmount.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.exchangeRate.tr,
            text2: controller.exchangeRate.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.totalFeesAndCharges.tr,
            text2: controller.totalFees.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.amountConvert.tr,
            text2: controller.amountWillConvert.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.willGetAmount.tr,
            text2: controller.willGetAmount.value,
          ),
        ],
      ),
    );
  }

  //account info
  _customInfoWidget(BuildContext context,
      {required String text1, required String text2}) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize * 0.54),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Expanded(
            flex: 0,
            child: TitleHeading5Widget(
              text: text1,
              fontWeight: FontWeight.w500,
              color: customTextColor.withOpacity(.40),
              maxLines: 1,
            ),
          ),
          Expanded(
            child: TitleHeading4Widget(
              text: text2,
              fontWeight: FontWeight.w600,
              color: customTextColor.withOpacity(0.60),
              textAlign: TextAlign.end,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

  _recipientInformationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * 0.7,
        right: Dimensions.paddingSize * 0.7,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius * 1.25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.paddingSize * 0.5,
              right: Dimensions.paddingSize * 0.5),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              verticalSpace(Dimensions.heightSize * 1.33),
              TitleHeading3Widget(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.375),
                text: Strings.recipientSummary.tr,
                fontWeight: FontWeight.w600,
                color: customTextColor,
              ),
              verticalSpace(Dimensions.heightSize * 2),
              _lineWidget(context),
              _customRecipientInformationWidget(context),
              verticalSpace(Dimensions.heightSize * 1.12),
            ],
          ),
        ),
      ),
    );
  }

  _customRecipientInformationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.375,
          right: Dimensions.paddingSize * 0.375),
      child: Column(
        children: [
          _customInfoWidget(
            context,
            text1: Strings.recipientName.tr,
            text2: controller.recipientName.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.country.tr,
            text2: controller.country.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.city.tr,
            text2: controller.city.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.zipCode.tr,
            text2: controller.zipCode.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.contactNumber.tr,
            text2: controller.contactNumber.value,
          ),
        ],
      ),
    );
  }

  _paymentInformationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * 0.7,
        right: Dimensions.paddingSize * 0.7,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.radius * 1.25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.paddingSize * 0.5,
              right: Dimensions.paddingSize * 0.5),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              verticalSpace(Dimensions.heightSize * 1.33),
              TitleHeading3Widget(
                padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.375),
                text: Strings.paymentSummary.tr,
                fontWeight: FontWeight.w600,
                color: customTextColor,
              ),
              verticalSpace(Dimensions.heightSize * 2),
              _lineWidget(context),
              _customPaymentInformationWidget(context),
              verticalSpace(Dimensions.heightSize * 1.12),
            ],
          ),
        ),
      ),
    );
  }

  _customPaymentInformationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.375,
          right: Dimensions.paddingSize * 0.375),
      child: Column(
        children: [
          _customInfoWidget(
            context,
            text1: Strings.receiveMethod.tr,
            text2: controller.transactionType.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.methodName.tr,
            text2: controller.bankName.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.accountNumber.tr,
            text2: controller.ibanNumber.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.sendingPurpose.tr,
            text2: controller.sendingPurpose.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.sourceOfFund.tr,
            text2: controller.sourceOfFund.value,
          ),
          _customInfoWidget(
            context,
            text1: Strings.paymentMethod.tr,
            text2: controller.paymentMethod.value,
          ),
        ],
      ),
    );
  }

//payment button
  _paymentButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isSubmitDataLoading
          ? const CustomLoadingAPI()
          : controller.alias.value.contains('manual')
              ? Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingSize * 0.78,
                    right: Dimensions.paddingSize * 0.78,
                    bottom: Dimensions.paddingSize,
                  ),
                  child: PrimaryButton(
                    title: Strings.confirm,
                    onPressed: () {
                      controller.onPaymentProcess();
                    },
                  ),
                )
              : AnimatedButton(
                  onComplete: () {
                    controller.onPaymentProcess();
                  },
                ),
    );
  }
}
