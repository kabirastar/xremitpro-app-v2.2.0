import '../../utils/basic_widget_imports.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.buttonColor,
    this.buttonTextColor = CustomColor.whiteColor,
    this.shape,
    this.icon,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final Color? borderColor;
  final double borderWidth;
  final double? height;
  final Color? buttonColor;
  final Color buttonTextColor;
  final OutlinedBorder? shape;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.buttonHeight * 0.8,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: shape ??
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7)),
          backgroundColor: buttonColor ?? CustomColor.primaryLightColor,
          side: BorderSide(
            width: borderWidth,
            color: borderColor ?? CustomColor.primaryLightColor,
          ),
        ),
        child: TitleHeading3Widget(
          text: title,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: buttonTextColor,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
