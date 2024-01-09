import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/money_transfer/money_transfer_controller.dart';
import '../../language/english.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../text_labels/title_heading3_widget.dart';
import '../text_labels/title_heading4_widget.dart';

class SelectMethodDropDownButtonWidget extends StatefulWidget {
  const SelectMethodDropDownButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectMethodDropDownButtonWidget> createState() =>
      _SelectMethodDropDownButtonWidgetState();
}

class _SelectMethodDropDownButtonWidgetState
    extends State<SelectMethodDropDownButtonWidget> {
  final MoneyTransferController controller = Get.put(MoneyTransferController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
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
              text: Strings.receivingMethod.tr,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.7),
              child: DropdownButton(
                iconEnabledColor: CustomColor.primaryLightColor,
                isExpanded: true,
                hint: Padding(
                  padding: EdgeInsets.only(right: Dimensions.paddingSize * 2),
                  child: TitleHeading4Widget(
                    text: Strings.selectReceivingMethod.tr,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                underline: Container(),
                value: controller.selectedItem.value,
                items: controller.itemList.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: TitleHeading3Widget(
                      fontWeight: FontWeight.w500,
                      text: item.toString(),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.selectedItem.value = newValue!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
