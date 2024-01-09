import '../../controller/money_transfer/money_transfer_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../drop_down/custom_input_drop_down_widget.dart';
import '../inputs/drop_down_widgets/pickup_point_widget.dart';
import '../inputs/text_input_field.dart';

class BankTransferWidget extends StatelessWidget {
  BankTransferWidget({
    super.key,

  });

  final MoneyTransferController controller = Get.put(MoneyTransferController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputDropDownWidget(
          text: Strings.bankTransfer.tr,
          onChanged: (v) {
            controller.selectedBankItem.value = v!;
          },
          itemsList: controller.bankItem,
          selectMethod: controller.selectedBankItem,
          widget: PickupPointWidget(
            text: Strings.selectReceivingBank.tr,
            icon: Assets.icon.bank,
          ),
        ),
        CustomTextInputField(
            controller: controller.accountHolderController,
            hintText: Strings.enterAccountHolderName.tr,
            icon: Assets.icon.user,
            inputText: Strings.accountHolderName.tr),
        CustomTextInputField(
          onEditingComplete: () {
            controller.goToRecipientInformationScreen();
          },
          controller: controller.accountNumberController,
          hintText: Strings.enterAccountNumber.tr,
          icon: Assets.icon.accountNumber,
          inputText: Strings.accountNumber.tr,
        ),
      ],
    );
  }
}
