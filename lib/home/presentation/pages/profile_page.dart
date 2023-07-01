import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/signin_page.dart';
import 'package:oech_app/core/states/main_state.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/home/presentation/pages/notifications_page.dart';
import 'package:oech_app/home/presentation/pages/payment_method_page.dart';
import 'package:oech_app/home/presentation/states/profile_state.dart';
import 'package:oech_app/home/presentation/widgets/profile_card_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(profileProvider).when(
        data: (value) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 63,
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey2Color),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://feyqfihsyhchwsjseqsg.supabase.co/storage/v1/object/public/images/profile_image.png?t=2023-06-29T11%3A00%3A58.645Z",
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.textColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Current balance:",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textColor),
                                ),
                                Text(
                                  ref.watch(profileDataProvider).isShowed
                                      ? value.balance
                                      : "******",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            ref.read(profileDataProvider.notifier).changeShowed();
                          },
                          child: ref.watch(profileDataProvider).isShowed
                              ? Image.asset(
                                  "assets/images/eye-slash.png",
                                  scale: 3.5,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: AppColors.text3Color,
                                  size: 20,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Enable dark Mode",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 43,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: ref.watch(themeProvider).darkMode,
                              onChanged: (value) {
                                ref.read(themeProvider.notifier).changeTheme();
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 19),
                    profileCardWidget(
                        "assets/images/edit_profile_icon.png",
                        "Edit Profile",
                        "Name, phone no, address, email ...",
                        () {}),
                    const SizedBox(height: 12),
                    profileCardWidget(
                        "assets/images/statements_icon.png",
                        "Statements & Reports",
                        "Download transaction details, orders, deliveries",
                        () {}),
                    const SizedBox(height: 12),
                    profileCardWidget(
                        "assets/images/notification_profile_icon.png",
                        "Notification Settings",
                        "mute, unmute, set location & tracking setting",
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
                        }),
                    const SizedBox(height: 12),
                    profileCardWidget(
                        "assets/images/card_icon.png",
                        "Card & Bank account settings",
                        "change cards, delete card details",
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodPage()));
                        }),
                    const SizedBox(height: 12),
                    profileCardWidget("assets/images/referrals_icon.png",
                        "Referrals", "check no of friends and earn", () {}),
                    const SizedBox(height: 12),
                    profileCardWidget("assets/images/about_icon.png", "About Us",
                        "know more about us, terms and conditions", () {
                    }),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        ref.read(profileDataProvider.notifier).logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SigninPage()),
                                (route) => false);
                      },
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
                                  "assets/images/logout_icon.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  "Log out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.textColor),
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
                    )
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stacktrace) {
          return Scaffold(
            body: Center(
              child: Text(error.toString()),
            ),
          );
        },
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
