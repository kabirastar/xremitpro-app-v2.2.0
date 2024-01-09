import 'package:flutter_html/flutter_html.dart';
import 'package:xremitpro/backend/local_storage/local_storage.dart';
import 'package:xremitpro/backend/utils/custom_loading_api.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/widgets/transaction_type/transaction_type_drop_down.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/inputs/apply_coupon_dialog.dart';
import '../../widgets/inputs/sending_currency_send_money.dart';
import '../../widgets/others/custom_image_widget.dart';

class DashboardMobileScreen extends StatelessWidget {
  DashboardMobileScreen({Key? key}) : super(key: key);
  final controller = Get.put(DashboardController());
  final primaryColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.primaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isTransactionTypeLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingSize, right: Dimensions.paddingSize),
      child: RefreshIndicator(
        onRefresh: () async {
          controller.getTransactionTypeInfoProcess();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(Dimensions.heightSize * 2.2),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: Dimensions.paddingSize * 0.75,
                  bottom: Dimensions.paddingSize,
                  left: Dimensions.paddingSize * 0.9,
                  right: Dimensions.paddingSize * 0.9,
                ),
                child: Column(
                  children: [
                    SendMoneySendingCurrencyDropdown(
                      controller: controller.amountController,
                      hint: '0.00',
                      items: controller
                          .getTransactionTypeModel.data.senderCurrency,
                      labelText: Strings.youSendExactly.tr,
                      borderColor: CustomColor.primaryLightColor,
                      flagPath: controller.flagPath.value,
                      onChanged: (value) {
                        controller.sendRemittanceProcess();
                      },
                      currencyHintText: controller.senderCurrencyCode.value,
                      onChangedCurrency: (currency) {
                        controller.senderCurrencyCode.value = currency!.code;
                        controller.senderCurrencyFlag.value =
                            "${controller.flagPath.value}${currency.flag}";
                        controller.senderCurrencyId.value =
                            currency.id.toString();
                        controller.sendRemittanceProcess();
                      },
                      flag: controller.senderCurrencyFlag.value,
                    ),
                    verticalSpace(Dimensions.heightSize * 1.33),
                    _transferCalculationWidget(context),
                    verticalSpace(Dimensions.heightSize * 1.33),
                    _recipientGetsWidget(context),
                    verticalSpace(Dimensions.heightSize * 0.5),
                    _applyCoupon(context),
                    _removeCoupon(context),
                    _transactionTypeDropDown(context),
                    Html(
                      data: Get.isDarkMode
                          ? controller.featureText.value.replaceAll(
                              'color:hsl(0, 0%, 0%)', 'color:hsl(0, 0%, 100%)')
                          : controller.featureText.value,
                    ),
                    verticalSpace(Dimensions.heightSize * 2),
                    _sendRemittanceWidget(context),
                  ],
                ),
              ),
              verticalSpace(Dimensions.heightSize * 0.75),
            ],
          ),
        ),
      ),
    );
  }

  //transfer calculation history
  _transferCalculationWidget(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: true,
        child: Column(
          children: [
            _textRowWidget(
              context,
              controller.feesAndCharges.value,
              Strings.transferFeesCharges.tr,
              Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor
                  : CustomColor.primaryLightColor,
              Assets.icon.minusIcon,
            ),
            verticalSpace(Dimensions.heightSize),
            _textRowWidget(
              context,
              controller.amountWillConvert.value,
              Strings.amountConvert.tr,
              Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor
                  : CustomColor.primaryLightTextColor.withOpacity(0.6),
              Assets.icon.equalIcon,
            ),
            verticalSpace(Dimensions.heightSize),
            _textRowWidget(
              context,
              controller.totalPayableAmount.value,
              Strings.totalPayableAmount.tr,
              Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor
                  : CustomColor.primaryLightColor,
              Assets.icon.crossIcon,
            ),
          ],
        ),
      ),
    );
  }

  //transactions history
  _textRowWidget(BuildContext context, String text1, String text2, Color color,
      String path) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        Row(
          children: [
            CustomImageWidget(path: path),
            horizontalSpace(Dimensions.widthSize * 0.8),
            TitleHeading4Widget(
              text: text1,
              fontWeight: FontWeight.w800,
              opacity: 0.4,
            ),
          ],
        ),
        Expanded(
          child: TitleHeading4Widget(
            text: text2,
            color: color,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }

  //recipient gets
  _recipientGetsWidget(BuildContext context) {
    return SendMoneySendingCurrencyDropdown(
      controller: controller.amountGetController,
      hint: '0.00',
      items: controller.getTransactionTypeModel.data.receiverCurrency,
      labelText: Strings.recipientGets.tr,
      borderColor: CustomColor.primaryLightColor,
      readOnly: true,
      flagPath: controller.flagPath.value,
      currencyHintText: controller.receiverCurrencyCode.value,
      flag: controller.receiverCurrencyFlag.value,
      onChangedCurrency: (currency) {
        controller.receiverCurrencyCode.value = currency!.code;
        controller.receiverCurrencyFlag.value =
            "${controller.flagPath.value}${currency.flag}";
        controller.receiverCurrencyId.value = currency.id.toString();
        controller.sendRemittanceProcess();
      },
    );
  }

  //send remittance button
  _sendRemittanceWidget(BuildContext context) {
    return PrimaryButton(
        title: Strings.sendRemittance.tr,
        onPressed: () {
          controller.onSendRemittance;
        },
        borderColor: CustomColor.primaryLightColor,
        buttonColor: CustomColor.primaryLightColor);
  }

  _transactionTypeDropDown(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TitleHeading4Widget(text: Strings.receiveMethod),
        ),
        Expanded(
          child: FittedBox(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Get.isDarkMode
                      ? CustomColor.primaryBGLightColor.withOpacity(0.5)
                      : CustomColor.primaryBGDarkColor.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: TransactionTypeDropDown(
                isMain: true,
              ),
            ),
          ),
        ),
      ],
    ).marginOnly(
      top: Dimensions.marginSizeVertical * 0.4,
      bottom: Dimensions.marginSizeVertical * 0.7,
    );
  }

  _applyCoupon(BuildContext context) {
    return Visibility(
      visible: controller.couponId.value == 0,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.marginSizeVertical * 0.25,
        ),
        child: Row(
          children: [
            Expanded(
              child: TitleHeading4Widget(
                text: Strings.haveACoupon,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                _openDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.marginSizeHorizontal,
                  vertical: Dimensions.marginSizeVertical * 0.4,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
                  color: CustomColor.primaryLightColor,
                ),
                child: TitleHeading4Widget(
                  text: Strings.apply,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whiteColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _removeCoupon(BuildContext context) {
    return Visibility(
      visible: controller.couponId.value != 0,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.marginSizeVertical * 0.25,
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                LocalStorage.removeCouponValue();
                controller.sendRemittanceProcess();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: CustomColor.redColor,
                  ),
                  TitleHeading4Widget(
                    text: Strings.removeCoupon,
                    color: CustomColor.redColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TitleHeading4Widget(
                text: Strings.applied,
                fontWeight: FontWeight.w700,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor
                    : CustomColor.primaryLightTextColor.withOpacity(0.6),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => ApplyCouponDialog().customGlassWidget(blurX: 1, blurY: 1),
    );
  }
}
