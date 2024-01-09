import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../widgets/others/custom_image_widget.dart';

// password input field
class CustomPasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final String icon;
  final String inputText;

  const CustomPasswordInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.readOnly = false,
      required this.icon,
      required this.inputText})
      : super(key: key);

  @override
  State<CustomPasswordInputField> createState() =>
      _PrimaryPasswordInputFieldState();
}

class _PrimaryPasswordInputFieldState extends State<CustomPasswordInputField> {
  FocusNode? focusNode;
  final secondaryColor = Get.isDarkMode
      ? CustomColor.primaryBGLightColor
      : CustomColor.secondaryLightColor;

  bool isObscure = true;

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
      shadowColor:
          Get.isDarkMode ? CustomColor.blackColor : CustomColor.whiteColor,
      elevation: focusNode!.hasFocus ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.paddingSize * 0.75,
            right: Dimensions.paddingSize * 0.75,
            top: Dimensions.paddingSize * 0.46),
        child: Column(
          crossAxisAlignment: crossStart,
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
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingSize * 0.54,
                  ),
                  child: CustomImageWidget(
                    height: Dimensions.heightSize * 1.533,
                    width: Dimensions.widthSize * 1.5975,
                    path: widget.icon,
                    color: focusNode!.hasFocus
                        ? secondaryColor
                        : secondaryColor.withOpacity(0.2),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: isObscure,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    style: CustomStyle.lightHeading3TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize3,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.secondaryLightTextColor),
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
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure
                              ? Icons.visibility_off
                              : Icons.visibility_outlined,
                          color: focusNode!.hasFocus
                              ? Get.isDarkMode
                                  ? CustomColor.primaryBGLightColor
                                  : CustomColor.primaryLightColor
                                      .withOpacity(.40)
                              : Get.isDarkMode
                                  ? CustomColor.primaryBGLightColor
                                      .withOpacity(0.50)
                                  : CustomColor.primaryLightTextColor
                                      .withOpacity(0.40),
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = isObscure ? false : true;
                          });
                        },
                      ),

                      hintText:
                          languageController.getTranslation(widget.hintText),
                      hintStyle: Get.isDarkMode
                          ? CustomStyle.darkHeading3TextStyle.copyWith(
                              color: CustomColor.primaryDarkTextColor
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.headingTextSize3 * 1,
                            )
                          : CustomStyle.lightHeading3TextStyle.copyWith(
                              color: CustomColor.primaryLightTextColor
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.normal,
                              fontSize: Dimensions.headingTextSize3 * 1,
                            ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // icon: CustomImageWidget(path: Assets.icon.search),
                      // labelText: widget.hintText,
                      labelStyle: TextStyle(
                        color: focusNode!.hasFocus
                            ? CustomColor.primaryLightColor.withOpacity(0.2)
                            : CustomColor.primaryLightColor.withOpacity(0.1),
                        fontSize: Dimensions.headingTextSize3,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
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
