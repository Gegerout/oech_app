import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/signin_page.dart';
import 'package:oech_app/auth/presentation/pages/signup_page.dart';
import 'package:oech_app/core/widgets/buttons.dart';
import 'package:oech_app/onboarding/data/models/onboarding_model.dart';
import 'package:oech_app/onboarding/presentation/states/onboarding_state.dart';
import 'package:oech_app/core/theme/colors.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(onboardingProvider).when(
        data: (value) {
          return Scaffold(
              body: SafeArea(
            child: PageView(
                        controller: controller,
                        onPageChanged: (index) {
                          ref.read(onboardingStateProvider.notifier).changeIndex(index);
                        },
                        children: [
                          onboardingCard(value[0], context),
                          onboardingCard(value[1], context),
                          onboardingEnd(value[2], context)
                        ]),
          ));
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

  Widget onboardingCard(OnboardingModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: 830,
          child: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  model.image,
                  width: double.infinity,
                  height: 346,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 53),
                Text(
                  model.title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  model.subtitle,
                  style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                DotsIndicator(
                  dotsCount: 3,
                  position: ref.watch(onboardingStateProvider).index,
                  decorator: DotsDecorator(
                      activeColor: AppColors.primaryColor,
                      color: AppColors.grey2Color,
                      activeSize: const Size(8.4, 8.4),
                      size: const Size(8.4, 8.4)),
                ),
                const SizedBox(height: 82),
                //const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3, bottom: 69),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 56,
                          height: 28,
                          child: secondaryButtonSmall("Skip", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                            ref.read(onboardingStateProvider.notifier).saveShowed();
                          }, FontWeight.w700, 9.385)),
                      const Spacer(),
                      SizedBox(
                          width: 56,
                          height: 28,
                          child: primaryButtonSmall("Next", () {
                            controller.animateToPage(
                                ref.watch(onboardingStateProvider).index + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }, FontWeight.w700, 9.385))
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  Widget onboardingEnd(OnboardingModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: 830,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                model.image,
                width: double.infinity,
                height: 346,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 53),
              Text(
                model.title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                model.subtitle,
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
              //const SizedBox(height: 48),
              const Spacer(),
              DotsIndicator(
                dotsCount: 3,
                position: ref.watch(onboardingStateProvider).index,
                decorator: DotsDecorator(
                    activeColor: AppColors.primaryColor,
                    color: AppColors.grey2Color,
                    activeSize: const Size(8.4, 8.4),
                    size: const Size(8.4, 8.4)),
              ),
              const SizedBox(height: 66),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: primaryButton("Sign Up", () {
                    ref.read(onboardingStateProvider.notifier).saveShowed();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  }, FontWeight.w700, 16)),
              Padding(
                padding:
                    const EdgeInsets.only(left: 3, right: 3, bottom: 47, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 14, color: AppColors.grey2Color),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    SizedBox(
                      width: 43,
                      height: 16,
                      child: TextButton(
                          onPressed: () {
                            ref.read(onboardingStateProvider.notifier).saveShowed();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
