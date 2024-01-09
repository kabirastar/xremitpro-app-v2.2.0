import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/basic_screen_imports.dart';

class CustomInputDropDownNewWidget extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;
  final String text;
  final bool isMain;

  const CustomInputDropDownNewWidget({
    required this.itemsList,
    Key? key,
    required this.selectMethod,
    this.onChanged,
    required this.text,
    this.isMain = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: isMain
            ? Colors.transparent
            : Get.isDarkMode
                ? CustomColor.primaryBGDarkColor
                : CustomColor.whiteColor,
        surfaceTintColor: isMain
            ? Colors.transparent
            : Get.isDarkMode
                ? CustomColor.primaryBGDarkColor
                : CustomColor.whiteColor,
        shadowColor: isMain ? Colors.transparent : CustomColor.blackColor,
        elevation: isMain ? 0 : null,
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Visibility(
              visible: !isMain,
              child: verticalSpace(Dimensions.marginSizeVertical * 0.65),
            ),
            Visibility(
              visible: !isMain,
              child: TitleHeading4Widget(
                padding: EdgeInsets.only(
                  left: Dimensions.paddingSize * 0.7,
                  right: Dimensions.paddingSize * 0.7,
                ),
                text: text,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingSize * 0.1,
                  ),
                  child: Text(
                    selectMethod.value,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.headingTextSize2 * 0.9,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor
                          : CustomColor.secondaryLightTextColor,
                    ),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  padding: isMain
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                          left: Dimensions.paddingSize * 0.7,
                          right: Dimensions.paddingSize,
                        ),
                ),
                isExpanded: isMain ? false : true,
                dropdownStyleData: DropdownStyleData(
                  useSafeArea: true,
                  elevation: 1,
                  width: isMain
                      ? MediaQuery.of(context).size.width * 0.39
                      : MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius),
                    ),
                  ),
                ),
                items: itemsList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(
                      value.toString(),
                      style: CustomStyle.lightHeading3TextStyle.copyWith(
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.secondaryLightTextColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                style: GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize2,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor
                      : CustomColor.secondaryLightTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
