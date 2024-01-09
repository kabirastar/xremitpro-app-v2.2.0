// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../utils/basic_screen_imports.dart';

abstract class DropdownModel {
  String get title;
  String get img;
}

class CustomDropDown<T extends DropdownModel> extends StatefulWidget {
  final String hint;
  final String flagPath;
  final String flag;
  final String title;
  final Color? borderColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final BoxBorder? border;
  final double? fieldBorderRadius;
  final Color? dropDownIconColor;
  final Color? titleTextColor;
  final Color dropDownFieldColor;
  final Color? dropDownColor;
  final bool isExpanded;
  final bool borderEnable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle;
  final BorderRadiusGeometry? customBorderRadius;
  const CustomDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.flag,
    this.border,
    this.fieldBorderRadius,
    this.dropDownIconColor,
    this.titleTextColor,
    this.dropDownFieldColor = Colors.transparent,
    this.isExpanded = true,
    this.padding,
    this.margin,
    this.titleStyle,
    this.borderColor,
    this.dropDownColor,
    required this.hint,
    this.borderEnable = true,
    this.title = '',
    required this.flagPath,
    this.customBorderRadius,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T extends DropdownModel>
    extends State<CustomDropDown<T>> {
  T? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return widget.title != ''
        ? Visibility(
            visible: widget.title != '',
            child: Column(
              crossAxisAlignment: crossStart,
              mainAxisSize: mainMin,
              children: [
                TitleHeading4Widget(
                  text: widget.title,
                  fontWeight: FontWeight.w500,
                ).paddingOnly(bottom: Dimensions.marginBetweenInputTitleAndBox),
                _dropDown()
              ],
            ))
        : _dropDown();
  }

  _dropDown() {
    return Container(
      height: Dimensions.inputBoxHeight * 0.69,
      padding: widget.padding ?? EdgeInsets.only(left: Dimensions.widthSize),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.dropDownFieldColor,
        border: widget.borderEnable
            ? widget.border ??
                Border.all(
                  color: widget.borderColor ??
                      (_selectedItem != null
                          ? Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                              : Theme.of(context).primaryColor
                          : CustomColor.whiteColor.withOpacity(0.15)),
                  width: 1.5,
                )
            : null,
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(
              widget.fieldBorderRadius ?? Dimensions.radius * 0.5,
            ),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.only(
                left: Dimensions.widthSize * 1.5,
                right: Dimensions.widthSize * 2.5,
              ),
          child: DropdownButton<T>(
            menuMaxHeight: MediaQuery.sizeOf(context).height * 0.2,
            hint: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.flag),
                    radius: Dimensions.radius * 3,
                  ),
                ),
                horizontalSpace(Dimensions.widthSize),
                Expanded(
                  flex: 3,
                  child: TitleHeading3Widget(
                    text: widget.hint,
                    fontWeight: FontWeight.w600,
                    color: _selectedItem != null
                        ? Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.primaryLightColor
                        : CustomColor.midGray,
                  ),
                ),
              ],
            ),
            value: _selectedItem,
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: widget.dropDownIconColor ??
                  (_selectedItem != null
                      ? Get.isDarkMode
                          ? Colors.grey
                          : Theme.of(context).primaryColor
                      : Colors.grey),
            ),
            style: TextStyle(
              color: widget.titleTextColor ??
                  (Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor
                      : Theme.of(context).primaryColor),
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: widget.dropDownColor ?? const Color(0xFF021A1B),
            isExpanded: widget.isExpanded,
            underline: Container(),
            borderRadius: BorderRadius.circular(Dimensions.radius),
            onChanged: (T? newValue) {
              setState(() {
                _selectedItem = newValue;
                widget.onChanged(_selectedItem);
              });
            },
            items: widget.items.map<DropdownMenuItem<T>>(
              (T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Row(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage("${widget.flagPath}${value.img}"),
                          radius: Dimensions.radius * 3,
                        ),
                      ),
                      horizontalSpace(Dimensions.widthSize),
                      Expanded(
                        flex: 3,
                        child: TitleHeading3Widget(
                          text: value.title,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                              : CustomColor.primaryLightColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
