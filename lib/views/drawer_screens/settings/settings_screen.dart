import '../../../language/language_drop_down.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/theme.dart';
import '../../../widgets/appbar/back_button.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.settings.tr,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSize * 0.7,
        right: Dimensions.paddingSize * 0.7,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          _kycWidget(context),
          _changeLanguageWidget(context),
          _changeThemeWidget(context),
        ],
      ),
    );
  }

  _changeLanguageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  TitleHeading4Widget(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSize * .2),
                    text: Strings.change,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize3,
                  ),
                  horizontalSpace(Dimensions.widthSize * 0.5),
                  TitleHeading4Widget(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSize * .2),
                    text: Strings.language,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize3,
                  ),
                ],
              ),
            ),
            Expanded(child: ChangeLanguageWidget())
          ],
        ),
        Divider(
          thickness: Dimensions.radius * .1,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }

  _changeThemeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 0.4,
      ),
      child: Row(
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainSpaceBet,
        children: [
          InkWell(
            onTap: () {
              Themes().switchTheme();
              Get.back();
            },
            child: TitleHeading4Widget(
              text: Strings.changeThemes,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize3,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize * 1.8,
            child: Switch.adaptive(
              value: Themes().theme == ThemeMode.dark,
              activeColor: CustomColor.whiteColor,
              onChanged: (value) {
                Themes().switchTheme();
              },
            ),
          )
        ],
      ),
    );
  }

  _kycWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.heightSize * 1.5,
        bottom: Dimensions.heightSize * 0.8,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.kycInformation);
            },
            child: TitleHeading4Widget(
              text: Strings.kycInformation,
              fontWeight: FontWeight.normal,
              fontSize: Dimensions.headingTextSize3,
            ),
          ),
          verticalSpace(Dimensions.heightSize * 0.5),
          Divider(
            thickness: Dimensions.radius * .1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
