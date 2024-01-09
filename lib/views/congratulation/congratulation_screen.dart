import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions.dart';
import '../../custom_assets/assets.gen.dart';
import '../../language/english.dart';
import '../../utils/size.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/others/custom_image_widget.dart';
import '../../widgets/text_labels/title_sub_title_widget.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.route,
  }) : super(key: key);
  final String title, subTitle, route;
  @override
  Widget build(BuildContext context) {
    Future<bool> willPop() {
      Get.offNamedUntil(route, (route) => false);
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        body: _bodyWidget(
          context,
        ),
      ),
    );
  }

  // body widget containing all widget elements
  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _imageWidget(context),
          verticalSpace(Dimensions.heightSize * 2),
          _congratulationInfoWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: PrimaryButton(
        title: Strings.okay,
        onPressed: () {
          Get.offNamedUntil(route, (route) => false);
        },
      ),
    );
  }

  _congratulationInfoWidget(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: Column(
        children: [
          TitleSubTitleWidget(
            title: title,
            subTitle: subTitle,
            isCenterText: true,
          ),
        ],
      ),
    );
  }

  //okay image
  _imageWidget(BuildContext context) {
    return CustomImageWidget(
      path: Assets.clipart.confirmationPng.path,
      width: MediaQuery.of(context).size.width * 0.59,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }
}
