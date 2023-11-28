import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool readOnly;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool obscureText;
  final InputDecoration? decoration;
  final InputBorder? enabledBorder;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isDense;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;

  const AppTextField({
    this.controller,
    this.labelText,
    this.labelStyle,
    this.readOnly = false,
    this.floatingLabelBehavior,
    this.obscureText = false,
    this.decoration,
    this.enabledBorder,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.isDense,
    this.validator,
    this.style,
    this.minLines,
    this.maxLines = 1,
    this.expands = false,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration ??
          InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            enabledBorder: enabledBorder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: labelText,
            labelStyle: labelStyle,
            floatingLabelBehavior: floatingLabelBehavior,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,

            prefix: prefix,
            isDense: isDense,
            errorStyle: const TextStyle(height: 0, fontSize: 0), // Hides the error text
          ),
      keyboardType: keyboardType,
      style: style,
      readOnly: readOnly,
      obscureText: obscureText,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      onChanged: onChanged,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
    );
  }
}

class AppDropdown extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? labelText;
  final TextStyle? labelStyle;
  final InputDecoration? decoration;
  final InputBorder? enabledBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isDense;
  final bool isExpanded;
  final Widget? icon;
  final Color? dropdownColor;
  final TextStyle? style;
  final String? Function(String?)? validator;

  const AppDropdown({
    this.items,
    this.value,
    this.onChanged,
    this.labelText,
    this.labelStyle,
    this.decoration,
    this.enabledBorder,
    this.suffixIcon,
    this.prefixIcon,
    this.isDense,
    this.isExpanded = false,
    this.icon,
    this.dropdownColor,
    this.style,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: decoration ??
          InputDecoration(
            enabledBorder: enabledBorder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            labelText: labelText,
            labelStyle: labelStyle,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            isDense: isDense,
          ),
      items: items,
      isExpanded: isExpanded,
      icon: icon,
      dropdownColor: dropdownColor,
      style: style,
      validator: validator,
    );
  }
}
