import 'package:google_fonts/google_fonts.dart';

import '../../utils/basic_screen_imports.dart';

class CustomInputDropDownWidget extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;
  final Widget widget;
  final String text;

  CustomInputDropDownWidget({
    required this.itemsList,
    Key? key,
    required this.selectMethod,
    this.onChanged,
    required this.widget,
    required this.text,
  }) : super(key: key);

  final RxBool isVisibility = false.obs;

  final RxBool isVisibility2 = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius * 0.583),
            ),
            border: Border.all(
              color: isVisibility.value == true
                  ? CustomColor.blackColor
                  : CustomColor.blackColor.withOpacity(0.20),
            ),
          ),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              DropdownButtonHideUnderline(
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
                            color: CustomColor.blackColor),
                      ),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: CustomColor.blackColor,
                      ),
                    ),
                    isExpanded: true,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    items: itemsList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString(),
                            style: CustomStyle.lightHeading3TextStyle.copyWith(
                              color: CustomColor.blackColor,
                            )),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    style: GoogleFonts.inter(
                      fontSize: Dimensions.headingTextSize2,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
