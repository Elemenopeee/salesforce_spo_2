import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class GuitarCentreInputField extends StatelessWidget {
  final String leadingIcon;

  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? floatingLabelTextStyle;
  final String label;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  /// This widget has been made for guitar centre.
  /// Widget comprises of label, masked formatter, validation and state management.
  /// Further enhancements can be made with respect to different masks, different validations, etc.

  const GuitarCentreInputField({
    required this.label,
    required this.leadingIcon,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.textInputType,
    this.floatingLabelTextStyle,
    this.inputFormatters,
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
          child: SvgPicture.asset(IconSystem.phone),
        ),
        Expanded(
          child: TextFormField(
            cursorHeight: SizeSystem.size16,
            cursorColor: Colors.black,
            cursorWidth: SizeSystem.size1,
            style: const TextStyle(
              fontSize: SizeSystem.size16,
              color: ColorSystem.primary,
            ),
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              label: Text(label),
              labelStyle: const TextStyle(
                color: ColorSystem.secondary,
                fontSize: SizeSystem.size12,
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
