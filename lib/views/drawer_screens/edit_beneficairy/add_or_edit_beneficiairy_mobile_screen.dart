import 'package:xremitpro/backend/utils/custom_loading_api.dart';
import 'package:xremitpro/controller/dashboard/dashboard_controller.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';
import 'package:xremitpro/views/add_new_recipient/screens/bank_transfer_screen.dart';

import '../../../backend/utils/custom_snackbar.dart';
import '../../../controller/drawer/edit_or_add_beneficiary_controller.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/transaction_type/transaction_type_drop_down.dart';
import '../../add_new_recipient/screens/mobile_money_screen.dart';

class AddOrEditBeneficiaryMobileScreen extends StatelessWidget {
  AddOrEditBeneficiaryMobileScreen({super.key, required this.controller});
  final EditOrAddBeneficiaryController controller;

  final formKey = GlobalKey<FormState>();
  final typeController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
            controller.clear();
          },
        ),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: controller.isAddingMode.value
              ? Strings.addRecipient
              : Strings.editBeneficiary,
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
    return Obx(
      () => Form(
        key: formKey,
        child: ListView(
          children: [
            TransactionTypeDropDown(),
            if (typeController.selectTransactionType.value == 'Bank Transfer' ||
                typeController.selectTransactionType.value ==
                    'Cash Pick Up') ...[
              Obx(
                () => BankTransferScreen(
                  onProceed: () {
                    if (formKey.currentState!.validate()) {
                      if (controller
                                  .bankTransferController.selectedBank.value ==
                              '' ||
                          controller
                                  .bankTransferController.selectedBank.value ==
                              'No bank found') {
                        CustomSnackBar.error(Strings.selectBanksName);
                      } else {
                        if (controller.isAddingMode.value) {
                          controller.onAddRecipient;
                        } else {
                          controller.onUpdateProcess;
                        }
                      }
                    }
                  },
                  isLoading: controller.isAddingMode.value
                      ? controller.isAddLoading
                      : controller.isUpdateLoading,
                  isAdd: controller.isAddingMode.value,
                ),
              )
            ] else if (typeController.selectTransactionType.value ==
                'Mobile Money') ...[
              MobileMoneyScreen(
                onProceed: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.mobileMoneyController.selectedMobileMethod
                                .value ==
                            '' ||
                        controller.mobileMoneyController.selectedMobileMethod
                                .value ==
                            'No method found') {
                      CustomSnackBar.error(Strings.selectMethodName);
                    } else {
                      if (controller.isAddingMode.value) {
                        controller.onAddRecipient;
                      } else {
                        controller.onUpdateProcess;
                      }
                    }
                  }
                },
                isLoading: controller.isAddingMode.value
                    ? controller.isAddLoading
                    : controller.isUpdateLoading,
                isAdd: controller.isAddingMode.value,
              ),
            ]
          ],
        ),
      ),
    ).marginSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.6);
  }
}
