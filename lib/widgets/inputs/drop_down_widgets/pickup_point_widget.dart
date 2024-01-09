import '../../../utils/basic_screen_imports.dart';
import '../../others/custom_image_widget.dart';

class PickupPointWidget extends StatelessWidget {
  const PickupPointWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final String icon;

//pickup point drop down widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.paddingSize * 0.58,
          top: Dimensions.heightSize * 0.3333),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.paddingSize,
                right: Dimensions.paddingSize * .45),
            child: CustomImageWidget(path: icon),
          ),
          TitleHeading3Widget(
            text: text,
            fontWeight: FontWeight.w500,
            color: CustomColor.primaryLightTextColor.withOpacity(0.40),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: Dimensions.paddingSize),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: CustomColor.primaryLightTextColor.withOpacity(0.40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
