import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Padding(
        padding: EdgeInsets.only(left: Dimensions.widthSize),
        child: Icon(
          Icons.arrow_back_ios,
          color: CustomColor.primaryLightColor,
          size: Dimensions.iconSizeLarge,
          weight: Dimensions.widthSize,
        ),
      ),
    );
  }
}
