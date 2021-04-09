import 'package:flutter/material.dart';
import 'package:onehub/style/borderRadiuses.dart';
import 'package:onehub/style/colors.dart';

class TextFieldTheme {
  static InputDecoration inputDecoration(
          {String? labelText,
          String? hintText,
          FocusNode? focusNode,
          IconData? icon}) =>
      InputDecoration(
        contentPadding: EdgeInsets.all(16),
        labelText: labelText,
        hintText: hintText?.replaceRange(0, 0, ' '),
        fillColor: AppColor.onBackground,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: focusNode?.hasFocus ?? false
                ? AppColor.grey3
                : AppColor.grey3.withOpacity(0.7),
          ),
        ),
        hintStyle:
            TextStyle(color: AppColor.grey3.withOpacity(0.7), fontSize: 12),
        filled: true,
        enabledBorder: _enabledBorder,
        focusedBorder: _focusedBorder,
        labelStyle: TextStyle(color: AppColor.grey3),
        border: _border,
      );

  static OutlineInputBorder _border =
      OutlineInputBorder(borderRadius: AppThemeBorderRadius.medBorderRadius);

  static OutlineInputBorder _enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: AppThemeBorderRadius.medBorderRadius);

  static OutlineInputBorder _focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.grey3),
      borderRadius: AppThemeBorderRadius.medBorderRadius);
}
