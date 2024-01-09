import '../../utils/basic_widget_imports.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 1.2,
    this.enabledBorderWidth = 1,
    this.color = Colors.white,
    required this.borderColor,
    this.suffixColor = Colors.white,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final Color borderColor;
  final Color? suffixColor;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.inputBoxHeight,
          width: double.infinity,
          child: TextFormField(
            readOnly: false,
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
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
                    color: widget.borderColor.withOpacity(0.4),
                    width: widget.enabledBorderWidth),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor,
                    width: widget.focusedBorderWidth),
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
              fillColor: widget.color,
              contentPadding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              hintText: widget.hintText,
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                    ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisibility ? Icons.visibility_off : Icons.visibility,
                  color: widget.suffixColor?.withOpacity(0.3),
                  size: Dimensions.iconSizeDefault,
                ),
                color: widget.color,
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
              ),
            ),
            obscureText: isVisibility,
          ),
        )
      ],
    );
  }
}
