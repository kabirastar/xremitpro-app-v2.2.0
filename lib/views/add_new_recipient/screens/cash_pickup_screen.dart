import '../../../controller/add_new_recipient/cash_pickup_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/drop_down/custom_input_drop_down_new.dart';
import '../../../widgets/inputs/country_picker_input_widget.dart';
import '../../../widgets/inputs/text_input_field.dart';

class CashPickupScreen extends StatelessWidget {
  CashPickupScreen({Key? key}) : super(key: key);
  final CashPickupController controller = Get.put(CashPickupController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _selectNameWidget(context),
          _selectEmailWidget(context),
          _selectCountryName(context, title: Strings.country.tr),
          _selectCityAndZipCodeWidget(context),
          _additionalAddressInfo(context),
          _phoneNumberWidget(context),
          _genderBirthdayWidget(context),
          _relationshipWidget(context),
          _receivingBankWidget(context),
          _accountNumberWidget(context),
          _addRecipientButtonWidget(context),
          verticalSpace(Dimensions.marginSizeVertical),
        ],
      ),
    );
  }

  //country picker
  _selectCountryName(BuildContext context, {required String title}) {
    return Card(
      color: CustomColor.whiteColor,
      surfaceTintColor: CustomColor.whiteColor,
      shadowColor: CustomColor.blackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeading4Widget(
            padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.75,
                top: Dimensions.paddingSize * 0.46),
            fontWeight: FontWeight.w600,
            text: title,
          ),
          ProfileCountryCodePickerWidget(
            controller: TextEditingController(text: Strings.usa.tr),
            onChanged: (value) {
              //controller.code.value = value.toString();
              controller.countryName.value = value.name;
            },
            hintText: Strings.name.tr,
          ),
        ],
      ),
    );
  }

//recipient name
  _selectNameWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.recipientNameController,
      hintText: Strings.enterRecipientName.tr,
      icon: Assets.icon.user,
      inputText: Strings.recipientName.tr,
    );
  }

//recipient email
  _selectEmailWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.recipientEmailAddressController,
      hintText: Strings.enterEmailAddress.tr,
      icon: Assets.icon.mail,
      inputText: Strings.enterEmailAddress.tr,
    );
  }

// recipient city selection and zip code input text
  _selectCityAndZipCodeWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: CustomInputDropDownNewWidget(
            onChanged: (v) {
              controller.selectedCity.value = v!;
            },
            itemsList: controller.city,
            selectMethod: controller.selectedCity,
            text: Strings.recipientCity.tr,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
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
      controller: controller.additionalAddressController,
      hintText: Strings.enterRoadLandmark.tr,
      icon: Assets.icon.pickupPoint,
      inputText: Strings.additionalAddressInfo.tr,
    );
  }

  // contact number input field
  _phoneNumberWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.recipientPhoneNumber,
      hintText: Strings.phoneNumberHintText.tr,
      icon: Assets.icon.phoneNumber,
      inputText: Strings.recipientPhoneNumber,
    );
  }

// gender and birthday
  _genderBirthdayWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: CustomInputDropDownNewWidget(
            itemsList: controller.gender,
            selectMethod: controller.selectedGender,
            text: Strings.gender.tr,
            onChanged: (v) {
              controller.selectedGender.value = v!;
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: CustomTextInputField(
            controller: controller.birthdayController,
            hintText: Strings.ddmmyyyy.tr,
            icon: Assets.icon.dob,
            inputText: Strings.dateOfBirth,
          ),
        ),
      ],
    );
  }

//relationship with recipient drop down button
  _relationshipWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      itemsList: controller.relationship,
      onChanged: (v) {
        controller.selectedRelationship.value = v!;
      },
      selectMethod: controller.selectedRelationship,
      text: Strings.relationshipWithRecipient.tr,
    );
  }

//receiving bank drop down
  _receivingBankWidget(BuildContext context) {
    return CustomInputDropDownNewWidget(
      onChanged: (v) {
        controller.selectedBank.value = v!;
      },
      itemsList: controller.bank,
      selectMethod: controller.selectedBank,
      text: Strings.receivingBank.tr,
    );
  }

// account number input field
  _accountNumberWidget(BuildContext context) {
    return CustomTextInputField(
      controller: controller.accountNumberController,
      hintText: Strings.enterAccountNumber.tr,
      icon: Assets.icon.accountNumber,
      inputText: Strings.accountNumber,
    );
  }

// add recipient button
  _addRecipientButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.paddingSize),
      child: PrimaryButton(
          title: Strings.addRecipient.tr,
          fontSize: Dimensions.headingTextSize2,
          fontWeight: FontWeight.w600,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.goToPaymentInformation();
            }
          },
          borderColor: CustomColor.primaryLightColor,
          buttonColor: CustomColor.primaryLightColor),
    );
  }
}
