import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';

class MoneyTransferController extends GetxController {
  RxString countryName = Strings.usa.obs;
  RxString code = "+1".obs;
  RxBool containerVisibility = false.obs;

  RxBool cashPickupVisibility = false.obs;
  RxBool bankTransferVisibility = false.obs;
  RxBool mobileMoneyVisibility = false.obs;

  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();

  // dispose all controller while the screen destroy
  @override
  void dispose() {
    accountNumberController.dispose();
    accountHolderController.dispose();
    super.dispose();
  }

  selectItem() {
    if (selectedItem.value == Strings.cashPickup) {
      cashPickupVisibility.value = true;
      bankTransferVisibility.value = false;
      mobileMoneyVisibility.value = false;
    }
  }

  selectItemBankTransfer() {
    if (selectedItem.value == Strings.bankTransfer) {
      cashPickupVisibility.value = false;
      bankTransferVisibility.value = true;
      mobileMoneyVisibility.value = false;
    }
  }

  selectItemMobileMoney() {
    if (selectedItem.value == Strings.mobileMoney) {
      cashPickupVisibility.value = false;
      bankTransferVisibility.value = false;
      mobileMoneyVisibility.value = true;
    }
  }

  RxString selectedItem = ''.obs;
  RxString selectedPickupItem = ''.obs;
  RxString selectedBankItem = ''.obs;

  List<String> itemList = [
    Strings.cashPickup.tr,
    Strings.bankTransfer.tr,
    Strings.mobileMoney.tr,
  ];
  List<String> pickupItem = [
    Strings.dhaka.tr,
    Strings.rangpur.tr,
    Strings.khulna.tr,
  ];
  List<String> bankItem = [
    Strings.unitedBank.tr,
    Strings.brackBank.tr,
    Strings.cityBank.tr,
  ];

  void goToRecipientInformationScreen() {
    Get.toNamed(Routes.recipientInformationScreen);
  }
}
