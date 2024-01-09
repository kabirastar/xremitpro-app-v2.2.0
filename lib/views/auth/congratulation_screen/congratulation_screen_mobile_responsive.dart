import '../../../../controller/auth/sign_in/sign_in_screen_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/others/custom_image_widget.dart';

class CongratulationScreenMobileResponsive extends StatelessWidget {
  CongratulationScreenMobileResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  final SignInScreenController controller = SignInScreenController();

//this widget contains a image, text and a button

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: crossCenter,
          children: [
            verticalSpace(Dimensions.marginSizeVertical * 4.5),
            _imageWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 0.67),
            _textWidget(context),
            _subHeadingTextWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * 1.33),
            _okayButtonWidget(context),
          ],
        ),
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

//congratulation text
  _textWidget(BuildContext context) {
    return TitleHeading1Widget(
      text: Strings.congratulation.tr,
      fontWeight: FontWeight.w600,
    );
  }

//description text
  _subHeadingTextWidget(BuildContext context) {
    return TitleHeading3Widget(
      text: Strings.passwordResetSuccessfully.tr,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w400,
    );
  }

  //okay button
  _okayButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.okay.tr,
      onPressed: () {
        controller.getOffAll();
      },
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightColor,
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.headingTextSize2,
    );
  }
}
