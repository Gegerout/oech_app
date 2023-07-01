import 'package:flutter/material.dart';
import 'package:oech_app/core/theme/colors.dart';

import '../../../core/extensions/extensions.dart';

Widget textField(String hintText, void Function(String value) onChanged,
    bool obscureText, Widget? suffixIcon, TextEditingController controller, TextInputType? keyboardType) {
  return Container(
    width: double.infinity,
    height: 44,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
    ),
    child: TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      obscuringCharacter: "*",
      inputFormatters: [
        hintText == "***********@mail.com" ? LowerCaseTextFormatter() : DefaultTextFormatter()
      ],
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.textColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: hintText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.grey1Color),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey2Color),
        ),
      ),
    ),
  );
}
