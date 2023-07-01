import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/arrow-square-right.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 114),
          child: Text(
            "Notification",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.grey2Color),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          Center(
              child: Image.asset(
            "assets/images/notification_page_icon.png",
            width: 83,
            height: 83,
            fit: BoxFit.fill,
          )),
          const SizedBox(height: 18),
          Text(
            "You have no notifications",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor),
          )
        ],
      ),
    );
  }
}
