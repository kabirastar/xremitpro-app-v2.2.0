import '../../controller/drawer/profile_screen_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../country_code_picker/country_code_picker_new_widget.dart';

class ProfileCountryCodePickerWidget extends StatelessWidget {
  const ProfileCountryCodePickerWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;

  // static String? countryName =;

  @override
  Widget build(BuildContext context) {
    final updateProfileController = Get.put(ProfileScreenController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimensions.inputBoxHeight * 0.80,
          width: double.infinity,
          child: CountryCodePickerNew(
            textStyle: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle
                    .copyWith(color: CustomColor.secondaryLightTextColor),
            onChanged: (value) {
              controller.text = value.name!;
              updateProfileController.selectCountryCode.value =
                  value.dialCode.toString();
              updateProfileController.selectCountry.value =
                  value.name.toString();
            },
            showOnlyCountryWhenClosed: true,
            showDropDownButton: true,
            flagDecoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius * 2)),
            ),
            initialSelection:
                controller.text.isNotEmpty ? controller.text : "United States",
            backgroundColor: Colors.transparent,
            boxDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            showCountryOnly: true,
            alignLeft: true,
            // searchStyle: Get.isDarkMode
            //     ? CustomStyle.darkHeading4TextStyle
            //     : CustomStyle.lightHeading4TextStyle,
            // dialogTextStyle: Get.isDarkMode
            //     ? CustomStyle.darkHeading4TextStyle
            //     : CustomStyle.lightHeading4TextStyle,
            onInit: (code) => {
              updateProfileController.countryController.text =
                  code!.name.toString(),
              updateProfileController.selectCountryCode.value =
                  code.dialCode.toString(),
            },
          ),
        ),
      ],
    );
  }
}
