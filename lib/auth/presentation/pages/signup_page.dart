import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/signin_page.dart';
import 'package:oech_app/auth/presentation/states/singup_state.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../widgets/text_field.dart';
import 'loading_page.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController nameCont = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: const Key("signupPage"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Text(
                  "Create an account",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  "Complete the sign up process to get started",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 30),
                Text(
                  "Full Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("Abecd   fsgh", (value) {}, false, null, nameCont,
                    TextInputType.name),
                const SizedBox(height: 24),
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("000000000000", (value) {}, false, null, phoneCont,
                    TextInputType.phone),
                const SizedBox(height: 24),
                Text(
                  "Email Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
                const SizedBox(height: 8),
                textField("***********@mail.com", (value) {
                  ref.read(signupProvider.notifier).checkEmail(value);
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
                    ref.watch(signupProvider).isShown,
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          ref.read(signupProvider.notifier).changeShown();
                        },
                        child: ref.watch(signupProvider).isShown ? Image.asset(
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
                          side: BorderSide(
                              color: AppColors.primaryColor, width: 1),
                          value: ref.watch(signupProvider).isChecked,
                          onChanged: (value) {
                            ref.read(signupProvider.notifier).changeChecked();
                          }),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrlString('https://vk.com/privacy');
                      },
                      child: SizedBox(
                        width: 271,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "By ticking this box, you agree to our",
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.grey2Color),
                                children: [
                                  TextSpan(
                                      text:
                                          " Terms and conditions and private policy",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.warningColor))
                                ])),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 64),
                SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: primaryButton("Sign Up", () {
                      if(nameCont.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Wrong name"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ));
                      } else if(phoneCont.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Wrong phone"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ));
                      } else if (!ref.watch(signupProvider).isEmail) {
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
                      } else if (!ref.watch(signupProvider).isChecked) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Not checked"),
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
                            .read(signupProvider.notifier)
                            .signupUser(nameCont.text, phoneCont.text,
                                emailCont.text, passwordCont.text)
                            .then((value) {
                          if (value != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SigninPage()),
                                (route) => false);
                          } else {
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
                      width: 43,
                      height: 16,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SigninPage()));
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            "Sign in",
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
                    "or sign in using",
                    style: TextStyle(fontSize: 14, color: AppColors.grey2Color),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: InkWell(
                      onTap: () {
                        ref.read(signupProvider.notifier).loginUserGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoadingPage()),
                        );
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
