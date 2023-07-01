import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oech_app/core/theme/colors.dart';

Widget packageTextField(String hintText, void Function(String value) onChanged,
    TextInputType keyboardType, {TextEditingController? controller}) {
  return Material(
    elevation: 1,
    color: Colors.white,
    child: SizedBox(
      width: double.infinity,
      height: 32,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 12, color: hintText == "Phone number" ?  AppColors.grey2Color :  AppColors.textColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12, color: AppColors.grey1Color),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}
