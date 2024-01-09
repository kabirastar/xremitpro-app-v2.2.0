import '../../utils/basic_widget_imports.dart';

class RecipientInformationInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;

  const RecipientInformationInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.readOnly = false})
      : super(key: key);

  @override
  State<RecipientInformationInputField> createState() =>
      _PrimaryInputFieldState();
}

//enter your mtcn number text input field
// here is search Icon and a text field inside a card
class _PrimaryInputFieldState extends State<RecipientInformationInputField> {
  FocusNode? focusNode;
  final secondaryColor = Get.isDarkMode
      ? CustomColor.secondaryDarkColor
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
      color: CustomColor.whiteColor,
      surfaceTintColor: CustomColor.whiteColor,
      shadowColor: CustomColor.blackColor,
      elevation: focusNode!.hasFocus ? 10 : 0,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.75),
            child: TitleHeading3Widget(
              text: Strings.to.tr,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? CustomColor.whiteColor
                  : CustomColor.secondaryLightTextColor,
            ),
          ),
          Expanded(
            child: TextFormField(
              readOnly: widget.readOnly,
              controller: widget.controller,
              style: CustomStyle.lightHeading3TextStyle.copyWith(
                  fontSize: Dimensions.headingTextSize3,
                  color: CustomColor.secondaryLightTextColor),
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
                hintText: widget.hintText,
                hintStyle: Get.isDarkMode
                    ? CustomStyle.darkHeading3TextStyle.copyWith(
                        color:
                            CustomColor.primaryDarkTextColor.withOpacity(0.3),
                        fontWeight: FontWeight.normal,
                        fontSize: Dimensions.heightSize * 1.33,
                      )
                    : CustomStyle.lightHeading3TextStyle.copyWith(
                        color:
                            CustomColor.primaryLightTextColor.withOpacity(0.3),
                        fontWeight: FontWeight.normal,
                        fontSize: Dimensions.heightSize * 1.33,
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
    );
  }
}
