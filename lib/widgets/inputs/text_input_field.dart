import 'package:flutter/services.dart';

import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../widgets/others/custom_image_widget.dart';

class CustomTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final String icon;
  final String inputText;
  final String visibleText;
  final bool isVisible;
  final bool isVisible2;
  final bool isValid;
  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final void Function()? onEditingComplete;

  const CustomTextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    this.isVisible = false,
    this.isValid = true,
    this.visibleText = '',
    this.icon = '',
    required this.inputText,
    this.onEditingComplete,
    this.inputFormatters,
    this.keyboardType,
    this.isVisible2 = false,
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _PrimaryTextInputFieldState();
}

class _PrimaryTextInputFieldState extends State<CustomTextInputField> {
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

  final languageController = Get.put(LanguageController());
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
                Expanded(
                  child: TitleHeading4Widget(
                    text: widget.inputText,
                    fontWeight: FontWeight.w600,
                    color: focusNode!.hasFocus
                        ? secondaryColor
                        : Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.primaryLightTextColor,
                    maxLines: 2,
                  ),
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
                widget.icon == ''
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                          right: Dimensions.paddingSize * 0.4654,
                        ),
                        child: CustomImageWidget(
                          height: Dimensions.heightSize * 1.167,
                          width: Dimensions.widthSize * 1.867,
                          path: widget.icon,
                          color: focusNode!.hasFocus
                              ? Get.isDarkMode
                                  ? CustomColor.primaryBGLightColor
                                  : CustomColor.secondaryLightTextColor
                              : Get.isDarkMode
                                  ? CustomColor.primaryBGLightColor
                                      .withOpacity(0.5)
                                  : CustomColor.primaryLightTextColor
                                      .withOpacity(0.4),
                        ),
                      ),
                Expanded(
                  child: TextFormField(
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    style: CustomStyle.lightHeading3TextStyle.copyWith(
                      fontSize: Dimensions.headingTextSize3,
                      color: Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor
                          : CustomColor.secondaryLightTextColor,
                    ),
                    validator: widget.isValid
                        ? (String? value) {
                            if (value!.isEmpty) {
                              return languageController.getTranslation(
                                  Strings.pleaseFillOutTheField);
                            } else {
                              return null;
                            }
                          }
                        : null,
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
                      hintText:
                          languageController.getTranslation(widget.hintText),
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
                      labelStyle: TextStyle(
                        color: focusNode!.hasFocus
                            ? CustomColor.secondaryLightTextColor
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
                        ? CustomColor.secondaryDarkTextColor
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
