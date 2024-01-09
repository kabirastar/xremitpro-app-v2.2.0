import 'dart:ui';

import 'package:xremitpro/backend/services/api_endpoint.dart';
import 'package:xremitpro/views/flutter_web/flutter_wab_screen.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../controller/drawer/drawer_widget_controller.dart';
import '../../controller/drawer/profile_screen_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../others/custom_container.dart';
import '../others/custom_image_widget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  final DrawerWidgetController controller = Get.put(DrawerWidgetController());
  final profileController = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? CustomColor.primaryBGDarkColor
              : CustomColor.primaryLightColor,
        ),
        child: _allItemListView(context),
      ),
    );
  }

// drawer item
  buildMenuItem(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSize,
          ),
          child: ListTile(
            dense: true,
            leading: CustomImageWidget(
              path: imagePath,
              height: Dimensions.heightSize * 2,
              width: Dimensions.widthSize * 2.3,
            ),
            title: TitleHeading4Widget(
              text: title,
              fontWeight: FontWeight.w600,
              color: CustomColor.whiteColor,
            ),
            onTap: onTap,
            horizontalTitleGap: Dimensions.marginSizeHorizontal * 0.3,
          ),
        ),
      ],
    );
  }

//drawer items
  _drawerItems(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(
          context,
          imagePath: Assets.icon.saved,
          title: Strings.savedRecipients.tr,
          onTap: () {
            controller.goSavedRecipientsScreen();
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.calculator,
          title: Strings.transferCalculator.tr,
          onTap: () {
            Get.toNamed(Routes.transferCalculatorScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.twofa,
          title: Strings.twoFASecurity.tr,
          onTap: () {
            controller.goToTwoFAScreen();
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.changePassword,
          title: Strings.changePassword.tr,
          onTap: () {
            controller.goToChangePasswordScreen();
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.settings,
          title: Strings.settings,
          onTap: () {
            Get.toNamed(Routes.settingsScreen);
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.helpCenter,
          title: Strings.helpCenter.tr,
          onTap: () {
            Get.to(
              () => FlutterWebScreen(
                title: Strings.helpCenter,
                paymentUrl: '${ApiEndpoint.mainDomain}/contact',
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.aboutUs,
          title: Strings.aboutUs.tr,
          onTap: () {
            Get.to(
              () => FlutterWebScreen(
                title: Strings.aboutUs,
                paymentUrl: '${ApiEndpoint.mainDomain}/about',
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.privacy,
          title: Strings.privacyAndPolicy.tr,
          onTap: () {
            Get.to(
              () => FlutterWebScreen(
                title: Strings.privacyAndPolicy,
                paymentUrl: '${ApiEndpoint.mainDomain}/link/privacy-policy',
              ),
            );
          },
        ),
        buildMenuItem(
          context,
          imagePath: Assets.icon.signOut,
          title: Strings.signOut.tr,
          onTap: () {
            signOutDialog(context, controller);
          },
        ),
      ],
    );
  }

  _allItemListView(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomImageWidget(
                path: Assets.icon.cross,
                color: CustomColor.whiteColor,
                height: Dimensions.heightSize,
                width: Dimensions.widthSize,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userImage(context),
            SizedBox(height: Dimensions.heightSize),
            TitleHeading2Widget(
              text: profileController.userFullName.value,
              color: CustomColor.whiteColor,
            ),
            SizedBox(height: Dimensions.heightSize * 0.2),
            TitleHeading4Widget(
              text: profileController.userEmailAddress.value,
              opacity: 0.5,
              color: CustomColor.whiteColor,
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
          ],
        ),
        _drawerItems(context),
      ],
    );
  }

  _userImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: CustomColor.whiteColor.withOpacity(0.05), width: 7),
      ),
      child: Center(
        child: CircleAvatar(
          radius: Dimensions.radius * 7,
          backgroundColor: CustomColor.whiteColor.withOpacity(0.30),
          child: CircleAvatar(
            backgroundColor: CustomColor.primaryLightColor,
            radius: Dimensions.radius * 6,
            child: ClipOval(
              child: FadeInImage(
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(profileController.userImage.value),
                placeholder: AssetImage(Assets.clipart.sampleProfile.path),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.clipart.sampleProfile.path,
                    height: double.infinity * 0.5,
                    width: double.infinity * 0.5,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

signOutDialog(BuildContext context, DrawerWidgetController controller) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Dialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: Column(
              crossAxisAlignment: crossStart,
              mainAxisSize: mainMin,
              children: [
                TitleHeading2Widget(
                  text: Strings.signOutAlert,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(Dimensions.heightSize),
                TitleHeading4Widget(
                  text: Strings.areYouSure,
                  textAlign: TextAlign.start,
                  opacity: 0.80,
                ),
                verticalSpace(Dimensions.heightSize),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: CustomContainer(
                          height: Dimensions.buttonHeight * 0.7,
                          borderRadius: Dimensions.radius * 0.8,
                          color: Get.isDarkMode
                              ? CustomColor.primaryBGLightColor
                                  .withOpacity(0.15)
                              : CustomColor.primaryBGDarkColor
                                  .withOpacity(0.15),
                          child: TitleHeading4Widget(
                            text: Strings.cancel,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(Dimensions.widthSize),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.signOutProcess();
                        },
                        child: Obx(
                          () => controller.isLoading
                              ? const CustomLoadingAPI()
                              : CustomContainer(
                                  height: Dimensions.buttonHeight * 0.7,
                                  borderRadius: Dimensions.radius * 0.8,
                                  color: CustomColor.primaryLightColor,
                                  child: TitleHeading4Widget(
                                    text: Strings.okay,
                                    color: CustomColor.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ).paddingAll(Dimensions.paddingSize * 0.5),
              ],
            ),
          ),
        ),
      );
    },
  );
}
