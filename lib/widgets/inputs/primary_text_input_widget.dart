import '../../utils/basic_widget_imports.dart';

class PrimaryTextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final Color borderColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final double hintFontSize;

  const PrimaryTextInputWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 1.2,
    this.enabledBorderWidth = 1,
    this.color = Colors.white,
    required this.borderColor,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon, this.hintFontSize = 12,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.inputBoxHeight,
          width: double.infinity,
          child: TextFormField(
            style: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle,
            readOnly: readOnly!,
            // style: CustomStyle.textStyle,
            controller: controller,
            keyboardType: keyboardType,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: BorderSide(
                    color: Colors.transparent,
                    width: enabledBorderWidth),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor, width: focusedBorderWidth),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              filled: true,

              fillColor: CustomColor.whiteColor,


              contentPadding: const EdgeInsets.only(
                  left: 16, right: 10, top: 20, bottom: 10),
              hintText: hintText,
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                      fontSize: hintFontSize,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                      fontSize: hintFontSize,
                    ),
              suffixIcon: suffixIcon ?? const SizedBox.shrink(),
              prefixIcon: prefixIcon ?? const SizedBox.shrink(),
            ),
          ),
        )
        // CustomSize.heightBetween()
      ],
    );
  }
}
