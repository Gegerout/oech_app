import 'package:flutter/cupertino.dart';
import 'package:oech_app/home/presentation/widgets/package_text_field.dart';

import '../../../core/theme/colors.dart';

Widget destinationCardWidget(TextEditingController address2, TextEditingController state2, TextEditingController phone2, void Function(String value) onChanged, int index) {
  return Column(
    children: [
      const SizedBox(height: 43),
      Row(
        children: [
          Image.asset(
            "assets/images/location_icon.png",
            width: 8,
            height: 12,
            fit: BoxFit.fill,
          ),
          const SizedBox(width: 8,),
          Text(
            "Destination Details",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor),
          )
        ],
      ),
      const SizedBox(height: 5),
      packageTextField("Address", onChanged, TextInputType.text, controller: index == 0 ? address2 : null),
      const SizedBox(height: 5),
      packageTextField("State,Country", onChanged, TextInputType.text, controller: index == 0 ? state2 : null),
      const SizedBox(height: 5),
      packageTextField("Phone number", onChanged, TextInputType.phone, controller: index == 0 ? phone2 : null),
      const SizedBox(height: 5),
      packageTextField("Others", onChanged, TextInputType.text),
      const SizedBox(height: 5),
    ],
  );
}