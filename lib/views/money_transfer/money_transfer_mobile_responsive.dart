import '../../controller/money_transfer/money_transfer_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/bank_transfer_widget/bank_transfer_widget.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/drop_down/custom_input_drop_down_widget.dart';
import '../../widgets/inputs/country_picker_input_widget.dart';
import '../../widgets/inputs/drop_down_widgets/drop_down_button_widget.dart';
import '../../widgets/inputs/drop_down_widgets/pickup_point_widget.dart';
import '../../widgets/others/custom_image_widget.dart';

class MoneyTransferMobileResponsive extends StatelessWidget {
  MoneyTransferMobileResponsive({
    super.key,
  });

  final MoneyTransferController controller = Get.put(MoneyTransferController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        title: CustomImageWidget(
          path: Assets.logo.logoPng.path,
          width: MediaQuery.of(context).size.width * 0.23,
          height: Dimensions.heightSize * 2.42,
        ),
        leading: GestureDetector(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * .70),
            child: CustomImageWidget(
              path: Assets.icon.drawer,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: DrawerWidget(),
      body: _bodyWidget(context),
    );
  }

  //this widget contains sending country, receiving country and multiple options for receiving method
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.paddingSize,
          right: Dimensions.paddingSize,
        ),
        child: Column(
          children: [
            _selectCountryWidget(context, title: Strings.sendingCountry.tr),
            _selectCountryWidget(context, title: Strings.receivingCountry.tr),
            _selectReceivingMethod(context),
            _cashPickupPoint(context),
            _bankTransferWidget(context),
          ],
        ),
      ),
    );
  }

  // select country option
  _selectCountryWidget(
    BuildContext context, {
    required String title,
  }) {
    return Card(
      color: CustomColor.whiteColor,
      surfaceTintColor: CustomColor.whiteColor,
      shadowColor: CustomColor.blackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.75,
                top: Dimensions.paddingSize * 0.46),
            fontWeight: FontWeight.w600,
            text: title,
          ),
          ProfileCountryCodePickerWidget(
            controller: TextEditingController(text: Strings.usa.tr),
            onChanged: (value) {
              controller.code.value = value.toString();
              controller.countryName.value = value.name;
              controller.containerVisibility.value = true;
            },
            hintText: Strings.name.tr,
          ),
        ],
      ),
    );
  }

//select money receiving method
  _selectReceivingMethod(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.containerVisibility.value,
        child: CustomInputDropDownWidget(
          text: Strings.receivingMethod.tr,
          onChanged: (v) {
            controller.selectedItem.value = v!;
            controller.selectItem();
            controller.selectItemBankTransfer();
            controller.selectItemMobileMoney();
            if (controller.selectedItem.value == Strings.mobileMoney) {
              controller.goToRecipientInformationScreen();
            }
          },
          itemsList: controller.itemList,
          selectMethod: controller.selectedItem,
          widget: ReceivingMethodWidget(
            text: Strings.selectReceivingMethod.tr,
          ),
        ),
      ),
    );
  }

  //pickup point widget
  _cashPickupPoint(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.cashPickupVisibility.value,
        child: CustomInputDropDownWidget(
          text: Strings.pickupPoint.tr,
          onChanged: (v) {
            controller.selectedPickupItem.value = v!;
            controller.goToRecipientInformationScreen();
          },
          itemsList: controller.pickupItem,
          selectMethod: controller.selectedPickupItem,
          widget: PickupPointWidget(
            text: Strings.selectPickupPoint.tr,
            icon: Assets.icon.bank,
          ),
        ),
      ),
    );
  }

//bank transfer
  _bankTransferWidget(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.bankTransferVisibility.value,
        child: BankTransferWidget(),
      ),
    );
  }
}
