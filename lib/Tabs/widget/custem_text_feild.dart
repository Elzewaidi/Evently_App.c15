import 'package:flutter/material.dart';
import 'package:eventlyapp/utils/styles.dart';

import '../../utils/app_colors.dart';

typedef MyValidator = String? Function(String?)?;

class CustomTextFiled extends StatelessWidget {
  Color? borderColor;
  bool obscureText;
  String hintText;
  String? labelText;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? labelStyle;
  int? maxLines = 1;
  TextStyle? style;
  MyValidator validator;
  TextInputType? keyBoardType;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;

  CustomTextFiled({
    this.onChanged,
    this.keyBoardType = TextInputType.text,
    this.validator,
    this.borderColor,
    required this.hintText,
    this.labelText,
    this.controller,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.labelStyle,
    this.style,
    this.obscureText = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLines ?? maxLines,
      validator: validator,
      cursorColor: AppColors.blackColor,
      style: style ?? AppStyles.medium16Black(context),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle,
        hintStyle: hintStyle ?? AppStyles.medium16Gray(context),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.greyColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.greyColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.redColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.redColor, width: 2),
        ),
      ),
    );
  }
}
