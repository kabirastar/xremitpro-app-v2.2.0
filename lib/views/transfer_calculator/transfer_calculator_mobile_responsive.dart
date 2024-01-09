import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '../../controller/transfer_calculator/transfer_calculator_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';
import '../../widgets/drop_down/custom_input_drop_down_widget.dart';
import '../../widgets/inputs/drop_down_widgets/drop_down_button_widget.dart';
import '../../widgets/inputs/sending_currency_send_money.dart';
import '../../widgets/others/custom_image_widget.dart';
import '../../widgets/transaction_type/transaction_type_drop_down.dart';

class TransferCalculatorScreenMobileResponsive extends StatelessWidget {
  TransferCalculatorScreenMobileResponsive({
    super.key,
  });

  final controller = Get.put(TransferCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.transferCalculator.tr,
          fontWeight: FontWeight.w600,
        ),
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(
        () => controller.isTransactionTypeLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
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
            _moneySendWidget(context),
            verticalSpace(Dimensions.heightSize * 1.33),
            _recipientGetsWidget(context),
            verticalSpace(Dimensions.heightSize * 1.33),
            _transferCalculationWidget(context),
            verticalSpace(Dimensions.heightSize * 1.33),
            _transactionTypeDropDown(context),
          ],
        ),
      ),
    );
  }

//select receiving method
  _selectReceivingMethod(BuildContext context) {
    return CustomInputDropDownWidget(
      text: Strings.receivingMethod.tr,
      onChanged: (v) {
        controller.selectTransactionType.value = v!;
      },
      itemsList: controller.transactionTypeList,
      selectMethod: controller.selectTransactionType,
      widget: ReceivingMethodWidget(
        text: Strings.selectTransactionType.tr,
      ),
    );
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

//money send
  _moneySendWidget(BuildContext context) {
    return SendMoneySendingCurrencyDropdown(
      controller: controller.amountController,
      hint: '0.00',
      items: controller.getTransactionTypeModel.data.senderCurrency,
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
        controller.senderCurrencyId.value = currency.id.toString();
        controller.sendRemittanceProcess();
      },
      flag: controller.senderCurrencyFlag.value,
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
}
