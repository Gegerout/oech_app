import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/signup_page.dart';
import 'package:oech_app/core/states/main_state.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/onboarding/presentation/pages/onboarding_page.dart';

Future<void> main() async {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            fontFamily: "Roboto"),
        home: ref.watch(mainProvider).when(
                data: (value) {
                  if(value) {
                    return SignupPage();
                  }
                  return OnboardingPage();
                },
                error: (error, stacktrace) {
                  return Scaffold(
                    body: AlertDialog(
                      title: Text(error.toString()),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"))
                      ],
                    ),
                  );
                },
                loading: () => const Scaffold(
                  body: Center(
                        child: CircularProgressIndicator(),
                      ),
                )
        )
    );
  }
}
