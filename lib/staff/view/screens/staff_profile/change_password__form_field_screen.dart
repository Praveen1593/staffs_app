import 'package:flutter/material.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';

class ChangePasswordTextInput extends StatelessWidget {
  const ChangePasswordTextInput(
      {Key? key,
      required this.onChanged,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.lableText,
      this.textInputAction,
      required this.controller,
      this.textCapitalization,
      this.lablestyle,
      this.focusNode})
      : super(key: key);

  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? lableText;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;
  final TextStyle? lablestyle;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (password) {
        if (password == null || password.isEmpty) {
          return Constants.login_key8;
        } else if (password.length < 6) {
          return Constants.login_key9;
        }
        return null;
      },
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        filled: true,
        fillColor:AppColors.whiteColor,
        labelText: lableText ?? "",
        labelStyle: lablestyle,
        errorStyle: const TextStyle(height: 0, color: AppColors.redColor),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}
