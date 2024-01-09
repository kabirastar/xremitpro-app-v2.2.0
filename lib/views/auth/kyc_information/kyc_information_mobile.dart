import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/auth/kyc_controller/kyc_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/kyc/kyc_status_widget.dart';

class KycInformationMobileResponsive extends StatelessWidget {
  KycInformationMobileResponsive({Key? key}) : super(key: key);
  final controller = Get.put(KycController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(onTap: () {
          Get.back();
        }),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.kycInformation.tr,
          color: CustomColor.primaryLightTextColor,
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
    var data = controller.kycInfoModel.data.kycStatus;
    return data == 2
        ? const StatusDataWidget(
            text: Strings.pending,
            icon: Icons.hourglass_empty,
          )
        : data == 1
            ? const StatusDataWidget(
                text: Strings.verified,
                icon: Icons.check_circle_outline,
              )
            : Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * 0.8,
                  vertical: Dimensions.paddingSize * 0.6,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    verticalSpace(Dimensions.heightSize * 0.5),
                    Obx(() {
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ...controller.inputFields.map((element) {
                              return element;
                            }).toList(),
                          ],
                        ),
                      );
                    }),
                    verticalSpace(Dimensions.heightSize),
                    Visibility(
                      visible: controller.inputFileFields.isNotEmpty,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              crossAxisSpacing: 10.0, // Spacing between columns
                              mainAxisSpacing: 10.0, // Spacing between rows
                              childAspectRatio: 0.752,
                            ),
                            itemCount: controller.inputFileFields.length,
                            // Number of items in the grid
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius),
                                  ),
                                  color: CustomColor.whiteColor,
                                ),
                                padding: EdgeInsets.all(
                                  Dimensions.paddingSize * 0.542,
                                ),
                                child: controller.inputFileFields[index],
                              );
                            }),
                      ),
                    ),
                    _buttonWidget(context),
                  ],
                ),
              );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => controller.isSubmitLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: (() {
                  if (formKey.currentState!.validate()) {
                    controller.kycSubmitApiProcess();
                  }
                }),
              ),
      ),
    );
  }
}
