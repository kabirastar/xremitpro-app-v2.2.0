import 'package:google_fonts/google_fonts.dart';

import '../../utils/basic_screen_imports.dart';

class TestDropDownButtonWidget extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;
  final Widget widget;
  final String text;

  const TestDropDownButtonWidget({
    required this.itemsList,
    Key? key,
    required this.selectMethod,
    this.onChanged,
    required this.widget,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: CustomColor.whiteColor,
          surfaceTintColor: CustomColor.whiteColor,
          shadowColor: CustomColor.blackColor,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              verticalSpace(Dimensions.marginSizeVertical * 0.75),
              TitleHeading4Widget(
                padding: EdgeInsets.only(left: Dimensions.paddingSize),
                text: text,
                fontWeight: FontWeight.w600,
              ),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingSize * 0.3, right: 20),
                  child: DropdownButton(
                    hint: Padding(
                      padding:
                          EdgeInsets.only(left: Dimensions.paddingSize * 0.7),
                      child: Text(
                        selectMethod.value,
                        style: GoogleFonts.inter(
                            fontSize: Dimensions.headingTextSize2 * 0.9,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.primaryLightColor),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: CustomColor.primaryLightColor,
                      ),
                    ),
                    isExpanded: true,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    items: itemsList.map((value) {
                      return DropdownMenuItem<String>(
                        enabled: true,
                        value: value,
                        child: Text(value,
                            style: CustomStyle.lightHeading3TextStyle.copyWith(
                              color: CustomColor.primaryLightColor,
                            )),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.headingTextSize2,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.primaryLightColor),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
