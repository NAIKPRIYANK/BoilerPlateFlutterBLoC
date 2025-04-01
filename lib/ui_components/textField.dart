// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/color_manager.dart';

import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final double width;
  final String hint;
  final String? labelText;
  final bool hideText;
  final void Function()? onTap;
  final RegExp? regExp;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final void Function(String data)? onSubmit;
  final void Function(String data)? onChanged;
  final void Function(bool data)? validateValue;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final BuildContext? context1;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;

  const InputField({
    this.context1,
    super.key,
    required this.controller,
    required this.width,
    required this.hint,
    this.labelText,
    this.prefixText,
    this.keyboardType,
    this.hideText = false,
    this.regExp,
    this.textInputType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.errorText,
    this.onTap,
    this.validateValue,
    this.onSubmit,
    this.onChanged,
    this.focusNode,
    this.suffixIcon,
    this.readOnly,
    this.inputFormatters,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: inputFormatters,
            readOnly: readOnly ?? false,
            onTap: onTap,
            focusNode: focusNode,
            maxLines: maxLines,
            maxLength: maxLength,
            controller: controller,
            keyboardType: textInputType,
            obscureText: hideText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (value) {
              if (maxLength != null && value.length > maxLength!) {
                controller?.text = value.substring(0, maxLength!);
                controller?.selection = TextSelection.fromPosition(
                  TextPosition(offset: maxLength!),
                );
              }

              if (onChanged != null) onChanged!(value);

              if (validateValue != null) {
                validateValue!(regExp?.hasMatch(value) ?? true);
              }
            },
            onFieldSubmitted: onSubmit,
            decoration: InputDecoration(
              prefixStyle:
                  GoogleFonts.roboto(color: Colors.black, fontSize: 16),
              prefixText: prefixText,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: ColorManager.textFieldColor, // Light background color
              labelText: labelText,
              labelStyle: GoogleFonts.roboto(
                  color: ColorManager.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              hintText: hint,
              hintStyle: GoogleFonts.roboto(color: ColorManager.grey),
              errorText: errorText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
              // Applying Border Radius
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none, // Remove default border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
            validator: (text) {
              if (labelText == "Website (optional)" &&
                  (text == null || text.isEmpty)) {
                return null;
              }

              if (labelText == "Incorporation Certificate Number" &&
                  (text == null || text.isEmpty)) {
                return null;
              }

              if (regExp != null && !regExp!.hasMatch("$text")) {
                if (validateValue != null) validateValue!(false);
                return "Entered $labelText is invalid";
              }

              if (validateValue != null) validateValue!(true);
              return null;
            },
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
