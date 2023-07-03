import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

Widget paymentCardWidget(String title, String subtitle, bool isTapped) {
  return Material(
    elevation: 3,
    color: isTapped ? const Color(0xFFDDECFF) : Colors.white,
    child: SizedBox(
      height: 84,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/radio_button.png",
              width: 12,
              height: 12,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: AppColors.textColor),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
