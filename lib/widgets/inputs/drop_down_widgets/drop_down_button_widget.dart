import '../../../utils/basic_screen_imports.dart';

class ReceivingMethodWidget extends StatelessWidget {
  const ReceivingMethodWidget({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingSize * 0.5,
        bottom: Dimensions.paddingSize * 0.5,
      ),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          TitleHeading3Widget(
            padding: EdgeInsets.only(left: Dimensions.paddingSize),
            text: text,
            fontWeight: FontWeight.w500,
            color: CustomColor.primaryLightTextColor.withOpacity(0.40),
          ),
          Padding(
            padding: EdgeInsets.only(right: Dimensions.paddingSize),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: CustomColor.primaryLightTextColor.withOpacity(0.40),
            ),
          ),
        ],
      ),
    );
  }
}
