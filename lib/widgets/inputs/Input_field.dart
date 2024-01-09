import '../../controller/track_your_transaction/track_your_transactions_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_widget_imports.dart';
import '../../widgets/others/custom_image_widget.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final bool readOnly;
  final void Function(String)? onFieldSubmitted;

  const InputField(
      {Key? key,
      required this.hintText,
      this.readOnly = false,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  State<InputField> createState() => _PrimaryInputFieldState();
}

// here is search Icon and a text field inside a card
class _PrimaryInputFieldState extends State<InputField> {
  FocusNode? focusNode;
  final secondaryColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.secondaryLightColor;
  final trackController = TrackYourTransactionController();

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
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.75),
            child: CustomImageWidget(
              height: Dimensions.heightSize * 2.1,
              width: Dimensions.widthSize * 2.1,
              path: Assets.icon.search,
              color: focusNode!.hasFocus
                  ? secondaryColor
                  : secondaryColor.withOpacity(0.2),
            ),
          ),
          Expanded(
            child: TextFormField(
              cursorColor: CustomColor.primaryLightColor,
              readOnly: widget.readOnly,
              controller: trackController.mtcnNumberController,
              style: CustomStyle.lightHeading3TextStyle.copyWith(
                fontSize: Dimensions.headingTextSize3,
                color: Get.isDarkMode ? CustomColor.whiteColor : null,
              ),
              textAlign: TextAlign.left,
              onTap: () {
                setState(() {
                  focusNode!.requestFocus();
                });
              },
              onFieldSubmitted: widget.onFieldSubmitted,
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
