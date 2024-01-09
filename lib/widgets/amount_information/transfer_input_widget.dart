import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class TransferInputWidget extends StatefulWidget {
  final String label, hintText;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function? onTap;

  const TransferInputWidget(
      {Key? key,
      required this.controller,
      required this.label,
      this.suffixWidget,
      this.onChanged,
      this.onTap,
      this.readOnly = false,
      this.hintText = '0.00'})
      : super(key: key);

  @override
  State<TransferInputWidget> createState() => _TransferInputWidgetState();
}

class _TransferInputWidgetState extends State<TransferInputWidget> {
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
        Text(
          widget.label,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
            widget.onTap!();
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          focusNode: focusNode,
          textAlign: TextAlign.left,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
              hintText: widget.hintText,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.widthSize * 1,
                  vertical: Dimensions.heightSize * 0.9),
              suffixIcon: widget.suffixWidget),
        ),
      ],
    );
  }
}
