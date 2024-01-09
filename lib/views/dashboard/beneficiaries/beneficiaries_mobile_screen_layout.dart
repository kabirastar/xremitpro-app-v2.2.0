import '../../../backend/model/send_remittance/beneficiarie_list_model.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/edit_or_add_beneficiary_controller.dart';
import '../../../controller/send_remittance/beneficiaries_controller.dart';
import '../../../extensions/custom_extensions.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/transfer_log/transfer_log_card.dart';

class BeneficiariesMobileScreenLayout extends StatelessWidget {
  BeneficiariesMobileScreenLayout({super.key});
  final controller = Get.put(BeneficiariesController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
        appBar: _appBarWidget(context),
        floatingActionButton: controller.isNext.value
            ? _nextButtonWidget()
            : _addBeneficiaryButton(),
        floatingActionButtonLocation: controller.isNext.value
            ? FloatingActionButtonLocation.centerFloat
            : null,
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getBeneficiariesListProcess();
      },
      child: controller.beneficiariesListModel.data.beneficiaries.isEmpty
          ? Center(
              child: TitleHeading2Widget(
                text: Strings.noRecipient,
                color: CustomColor.primaryLightColor,
              ),
            )
          : ListView(
              children: List.generate(
                controller.beneficiariesListModel.data.beneficiaries.length,
                (index) {
                  var data = controller
                      .beneficiariesListModel.data.beneficiaries[index];

                  var id = data.id;
                  return _beneficiaryWidget(
                    context,
                    beneficiaries: controller
                        .beneficiariesListModel.data.beneficiaries[index],
                    onTap: () {
                      if (controller.selectBeneficiary.value == id) {
                        controller.selectBeneficiary.value = 0;
                        controller.isNext.value = false;
                      } else {
                        controller.selectBeneficiary.value = id;
                        controller.isNext.value = true;
                        controller.onSendBeneficiary;
                      }
                    },
                    selected: controller.selectBeneficiary.value == id,
                  );
                },
              ),
            ),
    );
  }

  _appBarWidget(BuildContext context) {
    return PrimaryAppBar(
      leading: BackButtonWidget(onTap: () {
        Get.back();
      }),
      appBar: AppBar(),
      title: TitleHeading2Widget(
        text: Strings.recipientInformation.tr,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      autoLeading: false,
      appbarColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  _beneficiaryWidget(
    context, {
    required Beneficiary beneficiaries,
    required bool selected,
    required Function()? onTap,
  }) {
    var name =
        "${beneficiaries.firstName} ${beneficiaries.middleName} ${beneficiaries.lastName}";
    return Card(
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: selected
          ? CustomColor.greenColor.withOpacity(0.5)
          : Theme.of(context).colorScheme.background,
      shadowColor: CustomColor.blackColor,
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.8,
        right: Dimensions.marginSizeHorizontal * 0.8,
        bottom: Dimensions.marginSizeVertical * 0.33,
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: CustomColor.primaryLightColor,
            child: Icon(
              Icons.arrow_upward_outlined,
              color: CustomColor.whiteColor,
            ),
          ),
          title: TitleHeading3Widget(
            text: name,
            maxLines: 1,
          ),
          subtitle: TitleHeading4Widget(
            text: beneficiaries.method,
            maxLines: 1,
          ),
          trailing: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.45,
                vertical: Dimensions.marginSizeVertical * 0.25,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? CustomColor.greenColor
                    : CustomColor.primaryLightColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
              ),
              child: TitleHeading3Widget(
                text: selected ? Strings.selected : Strings.select,
                color: CustomColor.whiteColor,
              ),
            ),
          ),
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.7,
                vertical: Dimensions.marginSizeVertical * 0.7,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  LabelWidget(
                    title: Strings.name,
                    value: name,
                  ),
                  LabelWidget(
                    title: Strings.email,
                    value: beneficiaries.email,
                  ),
                  LabelWidget(
                    title: Strings.country,
                    value: beneficiaries.country,
                  ),
                  LabelWidget(
                    title: Strings.cityAndState,
                    value: beneficiaries.state,
                  ),
                  LabelWidget(
                    title: Strings.phone,
                    value: beneficiaries.phone,
                  ),
                  LabelWidget(
                    title: Strings.methodName,
                    value: beneficiaries.method,
                  ),
                  LabelWidget(
                    title: Strings.accountNumber,
                    value: beneficiaries.accountNumber,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _addBeneficiaryButton() {
    return FloatingActionButton(
      backgroundColor: CustomColor.primaryLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 10),
      ),
      onPressed: () {
        final controller = Get.put(EditOrAddBeneficiaryController());
        controller.isAddingMode.value = true;
        controller.onSendProcess.value = true;
        Routes.addOrEditBeneficiaryScreen.toNamed;
      },
      child: const Icon(Icons.add_outlined),
    );
  }

  _nextButtonWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
      child: PrimaryButton(
        title: Strings.next,
        onPressed: () {
          controller.onNext;
        },
      ),
    );
  }
}
