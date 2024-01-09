import 'package:xremitpro/backend/utils/custom_loading_api.dart';

import '../../controller/basic_settings/basic_settings_controller.dart';
import '../../controller/onboard/onboard_screen_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/onboard/onboard_screen_widget.dart';

class OnboardScreenMobileResponsiveLayout extends StatelessWidget {
  OnboardScreenMobileResponsiveLayout({
    super.key,
  });

  final controller = Get.put(OnboardScreenController());
  final basicSettingsController = Get.put(BasicSettingsController());
  final buttonBackGroundColor = Get.isDarkMode
      ? Colors.transparent
      : CustomColor.primaryLightColor.withOpacity(0.05);
  final whiteBlackColor = CustomColor.stateColor;
  final blackWhiteColor = CustomColor.blackColor;
  final customColor = CustomColor.secondaryLightTextColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => basicSettingsController.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

// image change, animated container, onboard widget(text, three buttons, sign up)
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _imageWidget(context),
          Column(
            children: [
              _animatedDotWidget(context),
              OnboardScreenWidget(),
            ],
          )
        ],
      ),
    );
  }

//onboard image
  _imageWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.selectedPageIndex,
        itemCount:
            basicSettingsController.appSettingsModel.data.onboardScreen.length,
        itemBuilder: (context, index) {
          var data = basicSettingsController
              .appSettingsModel.data.onboardScreen[index];
          return Image.network(
            "${basicSettingsController.path.value}${data.image}",
            width: MediaQuery.of(context).size.width * 0.62,
            height: MediaQuery.of(context).size.height * 0.27,
          );
        },
      ),
    );
  }

//changing dot
  _animatedDotWidget(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              basicSettingsController
                  .appSettingsModel.data.onboardScreen.length,
              (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: Dimensions.widthSize),
                  height: Dimensions.heightSize * 0.5,
                  width: index == controller.selectedPageIndex.value
                      ? Dimensions.widthSize * 3
                      : Dimensions.widthSize * 2,
                  decoration: BoxDecoration(
                    color: index == controller.selectedPageIndex.value
                        ? customColor
                        : customColor.withOpacity(0.20),
                    border: Border.all(
                      width: 2,
                      color: index == controller.selectedPageIndex.value
                          ? whiteBlackColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius * 5),
                    ),
                  ),
                );
              },
            ),
          ),
          verticalSpace(Dimensions.heightSize * 2),
          TitleHeading2Widget(
            text: basicSettingsController.appSettingsModel.data
                .onboardScreen[controller.selectedPageIndex.value].title,
            color: whiteBlackColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.paddingSize,
              right: Dimensions.paddingSize,
            ),
            child: TitleHeading4Widget(
              text: basicSettingsController.appSettingsModel.data
                  .onboardScreen[controller.selectedPageIndex.value].subTitle,
              textAlign: TextAlign.center,
              fontSize: Dimensions.headingTextSize3,
              color: whiteBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
