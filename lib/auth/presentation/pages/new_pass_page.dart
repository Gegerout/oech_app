import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/loading_page.dart';
import 'package:oech_app/auth/presentation/states/password_state.dart';
import 'package:oech_app/home/presentation/pages/home_page.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons.dart';
import '../widgets/text_field.dart';

class NewPassPage extends ConsumerWidget {
  NewPassPage({Key? key}) : super(key: key);

  final TextEditingController passwordCont1 = TextEditingController();
  final TextEditingController passwordCont2 = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 110),
                Text(
                  "New Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter new password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 48),
                Text(
                  "New Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("**********", (value) {}, true, null, passwordCont1,
                    TextInputType.visiblePassword),
                const SizedBox(height: 24),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("**********", (value) {}, true, null, passwordCont2,
                    TextInputType.visiblePassword),
                const SizedBox(height: 93),
                SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: primaryButton("Log in", () {
                      if(passwordCont1.text.isEmpty || passwordCont2.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Wrong password"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ));
                      } else if(passwordCont1.text != passwordCont2.text) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Passwords not match"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ));
                      } else {
                        ref.read(passwordProvider.notifier).updateUser(passwordCont1.text).then((value) {
                          if(value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(0)), (route) => false);
                          }
                          else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Something went wrong"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ],
                                )
                            );
                          }
                        });
                      }
                    }, FontWeight.w700, 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
