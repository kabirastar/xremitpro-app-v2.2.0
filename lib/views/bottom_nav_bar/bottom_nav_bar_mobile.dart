// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xremitpro/widgets/logo/basic_logo_widget.dart';

import '/custom_assets/assets.gen.dart';
import '/utils/basic_widget_imports.dart';
import '../../controller/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../language/language_controller.dart';
import '../../routes/routes.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class BottomNavBarMobileResponsive extends StatelessWidget {
  BottomNavBarMobileResponsive({Key? key}) : super(key: key);

  final controller = Get.put(BTMNavController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          scrolledUnderElevation: 0,
          leadingWidth: 80.w,
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: Dimensions.marginSizeHorizontal,
                left: Dimensions.marginSizeHorizontal,
              ),
              child: Icon(
                Iconsax.element_4,
                size: Dimensions.heightSize * 1.8,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: BasicLogoWidget(
            isDashBoard: true,
            isWhite: Get.isDarkMode ? true : false,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.profileScreen);
              },
              icon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSize * 0.75,
                ),
                child: Icon(
                  Iconsax.profile_circle,
                  size: Dimensions.heightSize * 2,
                  weight: Dimensions.headingTextSize1,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.body[controller.selectedIndex.value],
      ),
      bottomNavigationBar: _bottomNavBarWidget(context),
      floatingActionButton: _middleButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _bottomNavBarWidget(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(Dimensions.radius * 2.1)),
      child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          height: Dimensions.heightSize * 4.3,
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius * 2),
                  topLeft: Radius.circular(Dimensions.radius * 2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: mainSpaceBet,
                children: [
                  BottomItemWidget(
                      icon: Assets.icon.refresh, label: '', index: 0),
                  horizontalSpace(Dimensions.widthSize * 1.5),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: TitleHeading5Widget(
                        text: '',
                        color: CustomColor.primaryLightColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.5),
                  BottomItemWidget(
                    icon: Assets.icon.notificationbing,
                    label: '',
                    index: 1,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _middleButton(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 15),
          color: CustomColor.primaryDarkColor,
        ),
        child: SizedBox(
          child: InkWell(
            borderRadius: BorderRadius.circular(Dimensions.radius * 10),
            splashColor: CustomColor.whiteColor.withOpacity(0.5),
            focusColor: CustomColor.whiteColor.withOpacity(0.5),
            hoverColor: CustomColor.whiteColor.withOpacity(0.5),
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                Iconsax.send_2,
                color: CustomColor.whiteColor,
                size: 40,
              ),
            ),
            onTap: () {
              // LocalStorage.saveSendMoneyRoutes(isSendMoney: true);
              // Get.toNamed(Routes.dashboardScreen);
              controller.selectedIndex.value = 2;
            },
          ),
        ),
      ),
    );
  }
}

class BottomItemWidget extends StatelessWidget {
  BottomItemWidget({super.key, this.icon, required this.label, this.index});
  final String? icon;
  final String label;
  final int? index;
  final controller = Get.put(BTMNavController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedIndex.value = index!;
        controller.appTitle.value = controller.appTitleList[index!];
      },
      child: Obx(() => SizedBox(
            width: Dimensions.widthSize * 3,
            child: Column(
              children: [
                SvgPicture.asset(
                  icon ?? "",
                  height: 20,
                  width: 20,
                  color: controller.selectedIndex.value == index
                      ? Get.isDarkMode
                          ? CustomColor.whiteColor
                          : CustomColor.primaryLightColor
                      : Get.isDarkMode
                          ? CustomColor.whiteColor.withOpacity(0.5)
                          : CustomColor.primaryLightColor.withOpacity(0.5),
                ),
                verticalSpace(Dimensions.heightSize * 0.2),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize6 - 2,
                    color: controller.selectedIndex.value == index
                        ? CustomColor.primaryLightColor
                        : CustomColor.primaryLightColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
