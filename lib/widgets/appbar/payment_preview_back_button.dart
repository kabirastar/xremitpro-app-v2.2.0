import '../../utils/basic_widget_imports.dart';

class PaymentPreviewBackButtonWidget extends StatelessWidget {
  const PaymentPreviewBackButtonWidget({Key? key, required this.onTap})
      : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            Icons.arrow_back_ios,
            color: CustomColor.whiteColor,
            size: Dimensions.iconSizeLarge,
            weight: 10,
          ),
        ],
      ),
    );
  }
}
