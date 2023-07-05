import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/loading_page.dart';
import 'package:oech_app/auth/presentation/pages/password_page.dart';
import 'package:oech_app/auth/presentation/pages/signup_page.dart';
import 'package:oech_app/auth/presentation/states/signin_state.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons.dart';
import '../widgets/text_field.dart';

class SigninPage extends ConsumerWidget {
  SigninPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: const Key("signinPage"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 110),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill in your email and password to continue",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 48),
                Text(
                  "Email Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("***********@mail.com", (value) {
                  ref.read(signinProvider.notifier).checkEmail(value);
                }, false, null, emailCont, TextInputType.emailAddress),
                const SizedBox(height: 24),
                Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField(
                    "**********",
                    (value) {},
                    ref.watch(signinProvider).isShown,
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          ref.read(signinProvider.notifier).changeShown();
                        },
                        child: ref.watch(signinProvider).isShown ? Image.asset(
                          "assets/images/eye-slash.png",
                          scale: 3.5,
                        ) : Icon(Icons.visibility, color: AppColors.text3Color, size: 20,),
                      ),
                    ),
                    passwordCont,
                    TextInputType.visiblePassword),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: Checkbox(
                        activeColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          side:
                              BorderSide(color: AppColors.grey2Color, width: 1),
                          value: ref.watch(signinProvider).isChecked,
                          onChanged: (value) {
                            ref.read(signinProvider.notifier).changeChecked();
                          }),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Remember password",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.grey2Color),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 97,
                      height: 16,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasswordPage()));
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 169),
                SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: primaryButton("Log in", () {
                      if (!ref.watch(signinProvider).isEmail) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Wrong email"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ],
                                ));
                      } else if (passwordCont.text.isEmpty) {
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
                      } else {
                        ref
                            .read(signinProvider.notifier)
                            .loginUser(emailCont.text, passwordCont.text)
                            .then((value) {
                          if (value != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoadingPage()),
                                (route) => false);
                          }
                          else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Wrong creds"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ],
                                ));
                          }
                        });
                      }
                    }, FontWeight.w700, 16)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Already have an account?",
                      style:
                          TextStyle(fontSize: 14, color: AppColors.grey2Color),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    SizedBox(
                      width: 49,
                      height: 16,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "or log in using",
                    style: TextStyle(fontSize: 14, color: AppColors.grey2Color),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: InkWell(
                      onTap: () {
                        ref
                            .read(signinProvider.notifier)
                            .loginUserGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoadingPage()),);
                      },
                      child: Image.asset(
                        "assets/images/google_icon.png",
                        width: 16,
                        height: 16,
                        fit: BoxFit.fill,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
