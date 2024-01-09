// ignore_for_file: must_be_immutable

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xremitpro/backend/model/send_remittance/get_transaction_type_model.dart';

import '/utils/basic_widget_imports.dart';
import '../drop_down/drop_down.dart';

class SendMoneySendingCurrencyDropdown extends StatefulWidget {
  final List<ErCurrency> items;
  final String hint, icon, currencyHintText;
  final String? labelText;
  final String flagPath;
  final String flag;
  final int maxLines;
  final bool isValidator;
  final TextInputType? keyboardTypeC;
  final bool readOnly;
  final EdgeInsetsGeometry? paddings;
  final Function(String)? onChanged;
  final Function(ErCurrency?) onChangedCurrency;
  final TextEditingController controller;
  Color borderColor;

  SendMoneySendingCurrencyDropdown({
    Key? key,
    required this.controller,
    required this.hint,
    required this.currencyHintText,
    required this.flagPath,
    required this.flag,
    this.icon = "",
    this.borderColor = CustomColor.primaryLightTextColor,
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    this.labelText,
    this.keyboardTypeC,
    this.readOnly = false,
    this.onChanged,
    required this.onChangedCurrency,
    required this.items,

    // required this.itemsList,
    // this.onChanged,
  }) : super(key: key);

  @override
  State<SendMoneySendingCurrencyDropdown> createState() =>
      _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<SendMoneySendingCurrencyDropdown> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.labelText ?? "",
          fontSize: Dimensions.headingTextSize4,
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(Dimensions.heightSize * 0.3),
        TextFormField(
          cursorColor: CustomColor.primaryLightColor,
          readOnly: widget.readOnly,
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
          textInputAction: TextInputAction.next,
          controller: widget.controller,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          focusNode: focusNode,
          style: Get.isDarkMode
              ? CustomStyle.darkHeading3TextStyle
              : GoogleFonts.inter(
                  fontSize: Dimensions.headingTextSize3 + 2,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primaryLightTextColor,
                ),
          maxLines: widget.maxLines,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})')),

            /// decimal with 2 value after point
            LengthLimitingTextInputFormatter(7),
          ],
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelStyle: CustomStyle.darkHeading3TextStyle,
            hintText: widget.hint,
            hintStyle: Get.isDarkMode
                ? GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize3 + 2,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.primaryDarkTextColor.withOpacity(0.2),
                  )
                : GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize3 + 2,
                    fontWeight: FontWeight.w400,
                    color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                  ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
              borderSide: BorderSide(
                width: 1.5,
                color: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor.withOpacity(0.2)
                    : CustomColor.primaryLightTextColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide:
                  BorderSide(width: 2, color: CustomColor.primaryLightColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColor.redColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.heightSize * 1.7,
              vertical: Dimensions.heightSize,
            ),
            suffixIcon: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: CustomDropDown<ErCurrency>(
                borderEnable: false,
                items: widget.items,
                onChanged: widget.onChangedCurrency,
                hint: widget.currencyHintText,
                flagPath: widget.flagPath,
                flag: widget.flag,
                dropDownColor: Theme.of(context).colorScheme.background,
                titleTextColor: Get.isDarkMode
                    ? CustomColor.primaryDarkTextColor
                    : CustomColor.primaryLightTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
