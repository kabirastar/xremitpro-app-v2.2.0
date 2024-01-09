import 'dart:ui';

import 'package:xremitpro/backend/utils/custom_loading_api.dart';
import 'package:xremitpro/widgets/inputs/country_picker_input_widget.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../controller/drawer/profile_screen_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/inputs/text_input_field.dart';
import '../../../widgets/others/custom_container.dart';
import '../../../widgets/phone_number_input_field.dart';
import '../../../widgets/profile_view/profile_view.dart';

class ProfileScreenMobileResponsive extends StatelessWidget {
  ProfileScreenMobileResponsive({
    super.key,
  });

  final controller = Get.put(ProfileScreenController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        title: TitleHeading2Widget(
          text: Strings.profile.tr,
        ),
        leading: BackButtonWidget(
          onTap: () {
            Get.back();
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        autoLeading: true,
        appbarColor: Theme.of(context).scaffoldBackgroundColor,
        action: [
          GestureDetector(
            onTap: () {
              _deleteProfile(context, controller);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
                color: CustomColor.primaryLightColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 7, top: 5, bottom: 5),
                child: TitleHeading2Widget(
                  text: Strings.deleteProfile.tr,
                  color: CustomColor.whiteColor,
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  //this widget contains profile image, profile email and form field
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize * 0.7),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                horizontalSpace(Dimensions.widthSize * 0.6),
                ProfileViewWidget(
                  withButton: true,
                ),
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    TitleHeading2Widget(
                      text: controller.userFullName.value,
                      color: Get.isDarkMode
                          ? CustomColor.whiteColor
                          : CustomColor.secondaryLightTextColor,
                    ),
                    Row(
                      children: [
                        TitleHeading4Widget(
                          text: controller.userEmailAddress.value,
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode
                              ? CustomColor.whiteColor
                              : CustomColor.secondaryLightTextColor,
                        ),
                        horizontalSpace(Dimensions.marginSizeHorizontal * 0.2),
                        Visibility(
                          visible: LocalStorage.isUserVerified(),
                          child: Container(
                            height: Dimensions.heightSize,
                            width: Dimensions.widthSize * 1.2,
                            decoration: BoxDecoration(
                              color: CustomColor.greenColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius),
                            ),
                            child: Icon(
                              Icons.check,
                              color: CustomColor.whiteColor,
                              size: Dimensions.heightSize * 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                horizontalSpace(Dimensions.widthSize),
              ],
            ),
            _formField(context),
          ],
        ),
      ),
    );
  }

  _formField(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          verticalSpace(Dimensions.paddingSize),
          _enterNameWidget(context),
          _selectCountryName(context, title: Strings.country.tr),
          _phoneNumberWidget(context),
          _additionalAddressInfo(context),
          _stateInfoWidget(context),
          _recipientAndZipCodeWidget(context),
          verticalSpace(Dimensions.heightSize * 2),
          _updateProfileButtonWidget(context),
          verticalSpace(Dimensions.heightSize * 3),
        ],
      ),
    );
  }

  //country picker
  _selectCountryName(BuildContext context, {required String title}) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      shadowColor: CustomColor.blackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.75,
                right: Dimensions.paddingSize * 0.75,
                top: Dimensions.paddingSize * 0.46),
            fontWeight: FontWeight.w600,
            text: title,
          ),
          ProfileCountryCodePickerWidget(
            controller: controller.countryController,
            hintText: Strings.name.tr,
          ),
        ],
      ),
    );
  }

//first and last name
  _enterNameWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.44,
          child: CustomTextInputField(
            controller: controller.firstNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.group21,
            inputText: Strings.firstName.tr,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: CustomTextInputField(
            controller: controller.lastNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.group21,
            inputText: Strings.lastName.tr,
          ),
        ),
      ],
    );
  }

  //mobile number
  _phoneNumberWidget(BuildContext context) {
    return CustomPhoneTextInputField(
      controller: controller.mobileNumberController,
      hintText: Strings.phoneNumberHintText.tr,
      icon: Assets.icon.phoneNumber,
      inputText: Strings.phoneNumber.tr,
      code: '',
    );
  }

  _recipientAndZipCodeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextInputField(
            controller: controller.cityController,
            hintText: Strings.enterCity.tr,
            icon: Assets.icon.building,
            inputText: Strings.city.tr,
          ),
        ),
        Expanded(
          child: CustomTextInputField(
            controller: controller.zipCodeController,
            hintText: Strings.zipCode.tr,
            icon: Assets.icon.recipientCity,
            inputText: Strings.zipCode.tr,
          ),
        ),
      ],
    );
  }

  //address
  _additionalAddressInfo(BuildContext context) {
    return CustomTextInputField(
      controller: controller.addressController,
      hintText: Strings.enterRoadLandmark.tr,
      icon: Assets.icon.pickupPoint,
      inputText: Strings.address.tr,
    );
  }

  _stateInfoWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.stateController,
      hintText: Strings.enterState.tr,
      icon: Assets.icon.buildings,
      inputText: Strings.state.tr,
    );
  }

  //update profile button widget
  _updateProfileButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.updateProfile.tr,
              onPressed: () {
                controller.onUpdateProfile;
              },
              borderColor: CustomColor.primaryLightColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
    );
  }
}

_deleteProfile(BuildContext context, ProfileScreenController controller) {
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
                  text: Strings.deleteProfileAlert,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(Dimensions.heightSize),
                TitleHeading4Widget(
                  text: Strings.areYouSureDelete,
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
                          controller.onDeleteProcess;
                        },
                        child: Obx(
                          () => controller.isDeleteLoading
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
