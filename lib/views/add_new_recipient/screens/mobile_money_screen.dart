import 'package:xremitpro/backend/utils/custom_loading_api.dart';
import 'package:xremitpro/controller/dashboard/dashboard_controller.dart';
import 'package:xremitpro/widgets/drop_down/rx_dropDown.dart';

import '../../../controller/add_new_recipient/mobile_money_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/address/address_input_widget.dart';
import '../../../widgets/drop_down/custom_input_drop_down_new.dart';
import '../../../widgets/inputs/text_input_field.dart';
import '../../../widgets/phone_number_input_field.dart';
import '../../../widgets/upload/upload_picture.dart';

class MobileMoneyScreen extends StatelessWidget {
  MobileMoneyScreen(
      {Key? key,
      required this.onProceed,
      required this.isLoading,
      required this.isAdd})
      : super(key: key);
  final MobileMoneyController controller = Get.put(MobileMoneyController());
  final dashboardController = Get.put(DashboardController());
  final VoidCallback onProceed;
  final bool isLoading;
  final bool isAdd;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const CustomLoadingAPI()
          : Column(
              children: [
                _selectNameWidget(context),
                _selectMiddleAndLastName(context),
                _emailAddress(context),
                _selectCountryName(context, title: Strings.country.tr),
                _selectStateWidget(context),
                _selectCityAndZipCodeWidget(context),
                _phoneNumberWidget(context),
                _mobileMethodWidget(context),
                _contactNumberWidget(context),
                _additionalAddressInfo(context),
                _documentTypeWidget(context),
                verticalSpace(Dimensions.heightSize * 0.67),
                _uploadImageWidget(context),
                _addRecipientButtonWidget(context),
                verticalSpace(Dimensions.marginSizeVertical),
              ],
            ),
    );
  }

  //country picker
  _selectCountryName(BuildContext context, {required String title}) {
    return Obx(
      () => CustomInputDropDownNewWidget(
        text: Strings.country,
        onChanged: (v) {
          controller.selectCountry.value = v!;
          controller.getMobileMethodByCountry();
        },
        itemsList: dashboardController.receiverCountryList,
        selectMethod: controller.selectCountry == ''
            ? dashboardController.firstCountry
            : controller.selectCountry,
      ),
    );
  }

//recipient name
  _selectNameWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.recipientNameController,
      hintText: Strings.enterName.tr,
      icon: Assets.icon.group21,
      inputText: Strings.firstName.tr,
    );
  }

  //email
  _emailAddress(BuildContext context) {
    return CustomTextInputField(
      controller: controller.recipientEmailAddressController,
      hintText: Strings.enterEmailAddress,
      icon: Assets.icon.mail,
      inputText: Strings.emailAddress.tr,
    );
  }

// recipient city selection and zip code input text
  _selectCityAndZipCodeWidget(BuildContext context) {
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
            icon: Assets.icon.buildings2,
            inputText: Strings.zipCode.tr,
          ),
        ),
      ],
    );
  }

  //address
  _additionalAddressInfo(BuildContext context) {
    return CustomAddressTextInputField(
      controller: controller.additionalAddressController,
      hintText: Strings.writeHere.tr,
      icon: Assets.icon.pickupPoint,
      inputText: Strings.address.tr,
    );
  }

  // transaction type
  _documentTypeWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      text: Strings.documentType.tr,
      onChanged: (v) {
        controller.selectedDocumentItem.value = v!;
      },
      itemsList: controller.documentTypeList,
      selectMethod: controller.selectedDocumentItem,
    );
  }

  // contact number
  _phoneNumberWidget(BuildContext context) {
    return CustomPhoneTextInputField(
      controller: controller.recipientPhoneNumber,
      hintText: Strings.phoneNumberHintText.tr,
      icon: Assets.icon.phoneNumber,
      inputText: Strings.contactNumber.tr,
    );
  }

  // contact number
  _contactNumberWidget(BuildContext context) {
    return CustomPhoneTextInputField(
      controller: controller.accountNumberController,
      hintText: Strings.phoneNumberHintText.tr,
      icon: Assets.icon.accountNumber,
      inputText: Strings.accountNumber.tr,
    );
  }

  // button
  _addRecipientButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
      child: isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: isAdd ? Strings.confirm : Strings.update.tr,
              onPressed: onProceed,
              borderColor: CustomColor.primaryLightColor,
              buttonColor: CustomColor.primaryLightColor,
            ),
    );
  }

  //middle and last name
  _selectMiddleAndLastName(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextInputField(
            controller: controller.middleNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.group21,
            inputText: Strings.middleName.tr,
            isVisible2: true,
            isValid: false,
          ),
        ),
        Expanded(
          child: CustomTextInputField(
            controller: controller.lastNameController,
            hintText: Strings.enterName.tr,
            icon: Assets.icon.group21,
            inputText: Strings.lastName,
          ),
        )
      ],
    );
  }

  //state
  _selectStateWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.stateController,
      hintText: Strings.enterState.tr,
      icon: Assets.icon.buildings,
      inputText: Strings.state.tr,
    );
  }

  // transaction type
  _mobileMethodWidget(BuildContext context) {
    return RxInputDropDown(
      text: Strings.mobileMethod.tr,
      onChanged: (v) {
        controller.selectedMobileMethod.value = v!;
      },
      itemsList: controller.mobileMethodList,
      selectMethod: controller.selectedMobileMethod,
    );
  }

  _uploadImageWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ImagesUploadWidget(
            labelName: 'Font Part',
            fieldName: 'front_image',
            imageUrl: controller.frontImage.value,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: ImagesUploadWidget(
            labelName: 'Back Part',
            fieldName: 'back_image',
            imageUrl: controller.backImage.value,
          ),
        ),
      ],
    );
  }
}
