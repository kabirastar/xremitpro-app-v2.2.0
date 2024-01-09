import 'package:flutter_html/flutter_html.dart';
import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '../../controller/payment_information/payment_information_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/appbar/back_button.dart';
import '../../widgets/buttons/animated_button.dart';

class SendRemittanceManualPaymentScreen extends StatelessWidget {
  SendRemittanceManualPaymentScreen({super.key});

  final controller = Get.put(PaymentInformationController());
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
          text: Strings.evidenceNote,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: false,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSize * 0.7,
              vertical: Dimensions.paddingSize * 0.7,
            ),
            child: Column(
              children: [
                _descriptionWidget(context),
                ...controller.inputFields.map((element) {
                  return element;
                }).toList(),
              ],
            ),
          ),
          _buttonWidget(context)
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(() => controller.isConfirmLoading
          ? const CustomLoadingAPI()
          : AnimatedButton(
              onComplete: () {
                controller.manualPaymentProcess();
              },
            )),
    );
  }

  _descriptionWidget(BuildContext context) {
    final data = controller.manualPaymentModel.data;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.paddingSize * 0.5,
        horizontal: Dimensions.paddingSize * 0.2,
      ),
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 0.4),
      decoration: BoxDecoration(
        color: CustomColor.primaryLightColor,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        border: Border.all(
          width: 0.8,
          color: CustomColor.primaryLightColor.withOpacity(0.3),
        ),
      ),
      child: Html(
        data: data.details,
      ),
    );
  }
}
