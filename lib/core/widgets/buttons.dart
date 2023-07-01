import 'package:flutter/material.dart';
import 'package:oech_app/core/theme/colors.dart';

Widget primaryButton(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size, fontWeight: weight, color: Colors.white),
        )
  );
}

Widget secondaryButton(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(4))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: AppColors.primaryColor),
        )
  );
}

Widget disabledButton(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF292929), width: 1),
                borderRadius: BorderRadius.circular(4))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: const Color(0xFF434343)),
        )
  );
}

Widget primaryButtonSmall(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size, fontWeight: weight, color: Colors.white),
        )
  );
}

Widget secondaryButtonSmall(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: AppColors.primaryColor),
        )
  );
}

Widget disabledButtonSmall(String text, void Function() onPressed, FontWeight weight, double size) {
  return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF292929), width: 1),
                borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: const Color(0xFF434343)),
        )
  );
}