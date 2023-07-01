import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

Widget profileCardWidget(String image, String title, String subtitle, void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: double.infinity,
      height: 62,
      child: Material(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Row(
            children: [
              Image.asset(
                image,
                width: 20,
                height: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 9,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.textColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: AppColors.grey2Color),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF292D32),
                size: 14,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
