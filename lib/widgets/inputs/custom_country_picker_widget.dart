import '../../utils/basic_widget_imports.dart';
import '../country_code_picker/country_code_picker_new_widget.dart';

class CustomCountryPickerWidget extends StatelessWidget {
  const CustomCountryPickerWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.onChanged,
    this.customController,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;
  final dynamic customController;

  // static String? countryName =;

  @override
  Widget build(BuildContext context) {
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

              customController.selectCountry.value = value.name.toString();
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
            showCountryOnly: true,
            alignLeft: true,
            boxDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            onInit: (code) => {
              customController.countryController.text = code!.name.toString(),
            },
          ),
        ),
      ],
    );
  }
}
