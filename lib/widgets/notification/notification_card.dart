import '../../utils/basic_screen_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class NotificationCardWidget extends StatelessWidget {
  NotificationCardWidget({
    Key? key,
    required this.title,
    required this.title2,
    required this.day,
    required this.month,
  }) : super(key: key);

  final bgColor = Get.isDarkMode
      ? CustomColor.primaryDarkScaffoldBackgroundColor
      : CustomColor.primaryLightScaffoldBackgroundColor;

  final stateColor =
      Get.isDarkMode ? CustomColor.whiteColor : CustomColor.stateColor;

  final Color customColor = Get.isDarkMode
      ? CustomColor.whiteColor
      : CustomColor.secondaryLightTextColor;
  final String title, title2, day, month;

//transaction history card contains date, transaction number, email, money
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.65),
            child: Column(
              children: [
                TitleHeading1Widget(
                  text: day,
                  fontWeight: FontWeight.w600,
                  color: customColor,
                  maxLines: 1,
                ),
                TitleHeading4Widget(
                  text: month,
                  fontWeight: FontWeight.w500,
                  color: customColor,
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.heightSize * 3.5,
            decoration: BoxDecoration(
              border: Border.all(
                color: customColor.withOpacity(.30),
                width: 1,
              ),
            ),
          ),
          horizontalSpace(Dimensions.paddingSize * 0.625),
          Expanded(
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                TitleHeading1Widget(
                  text: title,
                  fontSize: Dimensions.headingTextSize3,
                  color: customColor,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                verticalSpace(Dimensions.heightSize * 0.33),
                TitleHeading5Widget(
                  text: title2,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  color: customColor.withOpacity(.50),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
