import '../../utils/basic_widget_imports.dart';
import '../../widgets/others/custom_image_widget.dart';

class CustomPhoneTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final String icon;
  final String inputText;
  final String visibleText;
  final bool isVisible;
  final bool isVisible2;
  final String code;

  final void Function()? onEditingComplete;

  const CustomPhoneTextInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.readOnly = false,
      this.isVisible = false,
      this.visibleText = '',
      required this.icon,
      required this.inputText,
      this.onEditingComplete,
      this.isVisible2 = false,
      this.code = ''})
      : super(key: key);

  @override
  State<CustomPhoneTextInputField> createState() =>
      _PrimaryTextInputFieldState();
}

class _PrimaryTextInputFieldState extends State<CustomPhoneTextInputField> {
  FocusNode? focusNode;
  final secondaryColor = Get.isDarkMode
      ? CustomColor.primaryDarkTextColor
      : CustomColor.secondaryLightColor;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      shadowColor: CustomColor.blackColor,
      elevation: focusNode!.hasFocus ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.paddingSize * 0.75,
          right: Dimensions.paddingSize * 0.75,
          top: Dimensions.paddingSize * 0.46,
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Row(
              children: [
                TitleHeading4Widget(
                  text: widget.inputText,
                  fontWeight: FontWeight.w600,
                  color: focusNode!.hasFocus
                      ? secondaryColor
                      : Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor
                          : CustomColor.primaryLightTextColor,
                ),
                horizontalSpace(Dimensions.widthSize * 0.1),
                Visibility(
                  visible: widget.isVisible2,
                  child: TitleHeading4Widget(
                    text: "(${Strings.optional.tr})",
                    fontSize: Dimensions.headingTextSize6,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.primaryLightColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingSize * 0.4654,
                  ),
                  child: CustomImageWidget(
                    height: Dimensions.heightSize * 1.167,
                    width: Dimensions.widthSize * 1.867,
                    path: widget.icon,
                    color: focusNode!.hasFocus
                        ? Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.secondaryLightTextColor
                        : Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor.withOpacity(0.5)
                            : CustomColor.primaryLightTextColor
                                .withOpacity(0.4),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    style: CustomStyle.lightHeading3TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize3,
                        color: Get.isDarkMode
                            ? CustomColor.whiteColor
                            : CustomColor.secondaryLightTextColor),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    textAlign: TextAlign.left,
                    onTap: () {
                      setState(() {
                        focusNode!.requestFocus();
                      });
                    },
                    onFieldSubmitted: (value) {
                      setState(() {
                        focusNode!.unfocus();
                      });
                    },
                    onEditingComplete: widget.onEditingComplete,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: widget.hintText.tr,
                      hintStyle: Get.isDarkMode
                          ? CustomStyle.darkHeading3TextStyle.copyWith(
                              color: CustomColor.primaryDarkTextColor
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.headingTextSize3 * 1.125,
                            )
                          : CustomStyle.lightHeading3TextStyle.copyWith(
                              color: CustomColor.primaryLightTextColor
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.headingTextSize3 * 1.125,
                            ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // icon: CustomImageWidget(path: Assets.icon.search),
                      // labelText: widget.hintText,
                      labelStyle: TextStyle(
                        color: focusNode!.hasFocus
                            ? Get.isDarkMode
                                ? CustomColor.primaryDarkTextColor
                                : CustomColor.secondaryLightTextColor
                                    .withOpacity(0.2)
                            : CustomColor.primaryLightColor.withOpacity(0.1),
                        fontSize: Dimensions.headingTextSize3,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Visibility(
                  visible: focusNode!.hasFocus ? widget.isVisible : false,
                  child: TitleHeading2Widget(
                    padding: EdgeInsets.only(right: Dimensions.paddingSize),
                    text: widget.visibleText,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize2 * 0.9,
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor
                        : CustomColor.secondaryLightTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
