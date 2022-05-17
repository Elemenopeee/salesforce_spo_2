import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

class GuitarCentreInputField extends StatelessWidget {
  final String leadingIcon;

  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? floatingLabelTextStyle;
  final String label;
  final String? hintText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;

  /// This widget has been made for guitar centre.
  /// Widget comprises of label, masked formatter, validation and state management.
  /// Further enhancements can be made with respect to different masks, different validations, etc.

  const GuitarCentreInputField({
    required this.label,
    required this.leadingIcon,
    this.onChanged,
    this.hintText,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.textInputType,
    this.floatingLabelTextStyle,
    this.inputFormatters,
    this.initialText,
    this.onFieldSubmitted,
    this.focusNode,
    this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: PaddingSystem.padding16,
            right: PaddingSystem.padding28,
            top: PaddingSystem.padding20,
            bottom: PaddingSystem.padding20,
          ),
          child: SvgPicture.asset(
            leadingIcon,
            width: SizeSystem.size24,
            height: SizeSystem.size24,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            initialValue: initialText,
            cursorHeight: SizeSystem.size16,
            cursorColor: Colors.black,
            cursorWidth: SizeSystem.size1,
            style: const TextStyle(
              fontSize: SizeSystem.size16,
              color: ColorSystem.primary,
            ),
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ColorSystem.primary, width: 1),
              ),
              hintText: hintText,
              label: Text(label),
              labelStyle: const TextStyle(
                color: ColorSystem.secondary,
                fontSize: SizeSystem.size14,
                fontFamily: kRubik,
              ),
              floatingLabelBehavior: floatingLabelBehavior,
              floatingLabelStyle: floatingLabelTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
