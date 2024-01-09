

import 'package:get/get.dart';

import '../custom_assets/assets.gen.dart';
import '../language/english.dart';

class OnboardModel {
  final String imagePath;
  final String title;
  final String subTitle;

  OnboardModel(
      {required this.imagePath, required this.title, required this.subTitle});
}

List<OnboardModel> onBoardModePages = [
  OnboardModel(
    title: Strings.welcomeToXRemit.tr,
    subTitle:Strings.onboardSubtitleText.tr
    ,
    imagePath: Assets.onboard.onboard1.path,
  ),
  OnboardModel(
    title: Strings.safeAndSecureProcess.tr,
    subTitle: Strings.onboardSubtitleText.tr
    ,
    imagePath: Assets.onboard.onboard2.path,
  ),
  OnboardModel(
    title: Strings.customerSupport.tr,
    subTitle: Strings.onboardSubtitleText.tr
    ,
    imagePath: Assets.onboard.onboard3.path,
  ),
];
