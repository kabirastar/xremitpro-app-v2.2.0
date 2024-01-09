import 'package:xremitpro/backend/utils/custom_loading_api.dart';
import 'package:xremitpro/controller/drawer/edit_or_add_beneficiary_controller.dart';
import 'package:xremitpro/controller/drawer/saved_beneficairy_controller.dart';
import 'package:xremitpro/extensions/custom_extensions.dart';
import 'package:xremitpro/routes/routes.dart';

import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/others/custom_image_widget.dart';
import '../../../widgets/recipient_information/recipient_information_card_widget.dart';

class SavedBeneficiaryMobileResponsive extends StatelessWidget {
  SavedBeneficiaryMobileResponsive({
    super.key,
  });

  final secondaryCustomColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.secondaryLightTextColor;
  final controller = Get.put(SavedBeneficiaryController());
  final editController = Get.put(EditOrAddBeneficiaryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.savedRecipients.tr,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 10),
        ),
        onPressed: () {
          editController.isAddingMode.value = true;
          Routes.addOrEditBeneficiaryScreen.toNamed;
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: CustomImageWidget(
          path: Assets.icon.add,
          height: Dimensions.heightSize * 6.34,
          width: Dimensions.widthSize * 7.65,
        ),
      ),
      body: Obx(
        () => controller.isLoading || editController.isDeleteLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * 0.7,
        right: Dimensions.paddingSize * 0.7,
      ),
      child: RefreshIndicator(
        color: CustomColor.primaryLightColor,
        onRefresh: () async {
          controller.getBeneficiaryApiProcess();
        },
        child: controller.beneficiaryInfoModel.data.beneficiaries.isEmpty
            ? Center(
                child: TitleHeading2Widget(
                  text: Strings.noRecipient,
                  color: CustomColor.primaryLightColor,
                  fontSize: Dimensions.headingTextSize2 * 0.8,
                  opacity: 0.8,
                ),
              )
            : ListView.builder(
                itemCount:
                    controller.beneficiaryInfoModel.data.beneficiaries.length,
                itemBuilder: (BuildContext context, int index) {
                  var data =
                      controller.beneficiaryInfoModel.data.beneficiaries[index];
                  return RecipientInformationCardWidget(
                    secondaryCustomColor: secondaryCustomColor,
                    text:
                        "${data.firstName} ${data.middleName} ${data.lastName}",
                    subText: data.method,
                    onEdit: () {
                      editController.isAddingMode.value = false;
                      editController.selectBeneficiaryId.value =
                          data.id.toString();
                      editController.getBeneficiaryApiProcess(data.id).then(
                            (value) =>
                                Routes.addOrEditBeneficiaryScreen.toNamed,
                          );
                    },
                    onDelete: () {
                      editController.selectBeneficiaryId.value =
                          data.id.toString();
                      editController.deleteBeneficiaryProcess();
                    },
                    beneficiaries: controller
                        .beneficiaryInfoModel.data.beneficiaries[index],
                  );
                },
              ),
      ),
    );
  }
}
