import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '/widgets/drop_down/custom_input_drop_down_new.dart';
import '../../controller/payment_information/payment_information_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/address/address_input_widget.dart';
import '../../widgets/appbar/back_button.dart';

class PaymentInformationMobileResponsive extends StatelessWidget {
  PaymentInformationMobileResponsive({
    super.key,
  });

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
          text: Strings.recipientPayment.tr,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: false,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

//this widget contains sending purpose, source of fund, payment gateway
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.7,
            right: Dimensions.paddingSize * 0.7),
        child: Column(
          children: [
            _textInputWidget(context),
            _textFundWidget(context),
            _remarksInfoWidget(context),
            _textPaymentWidget(context),
            _proceedButtonWidget(context),
          ],
        ),
      ),
    );
  }

//sending purpose
  _textInputWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      text: Strings.sendingPurpose.tr,
      onChanged: (v) {
        controller.selectedSendingPurposeName.value = v!;
        controller.selectedSendingPurposeId.value =
            controller.sendingPurposeIdList[controller.sendingPurposeNameList
                .indexOf(controller.selectedSendingPurposeName.value)];
      },
      itemsList: controller.sendingPurposeNameList,
      selectMethod: controller.selectedSendingPurposeName,
    );
  }

//source of fund
  _textFundWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      text: Strings.sourceOfFund.tr,
      onChanged: (v) {
        controller.selectedFundItem.value = v!;
        controller.selectedFundId.value = controller.sendingPurposeIdList[
            controller.sendingPurposeNameList
                .indexOf(controller.selectedFundItem.value)];
      },
      itemsList: controller.sourceOfFundNameList,
      selectMethod: controller.selectedFundItem,
    );
  }

//payment gateway
  _textPaymentWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      text: Strings.paymentGateway.tr,
      onChanged: (v) {
        controller.selectedPaymentMethod.value = v!;
        controller.selectedPaymentMethodId.value =
            controller.paymentGatewayIdList[controller.paymentGatewayNameList
                .indexOf(controller.selectedPaymentMethod.value)];

        debugPrint(controller.selectedPaymentMethodId.value);
      },
      itemsList: controller.paymentGatewayNameList,
      selectMethod: controller.selectedPaymentMethod,
    );
  }

  _proceedButtonWidget(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSize * 1.67),
        child: controller.isStoreLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.proceed.tr,
                onPressed: () {
                  controller.receiptPaymentStoreProcess();
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }

  _remarksInfoWidget(BuildContext context) {
    return CustomAddressTextInputField(
      controller: controller.remarksController,
      hintText: Strings.writeHere.tr,
      icon: Assets.icon.pickupPoint,
      inputText: Strings.remarks.tr,
      optionalVisible: true,
      iconVisible: false,
    );
  }
}
