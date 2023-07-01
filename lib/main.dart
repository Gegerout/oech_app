import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/core/states/main_state.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/home/presentation/pages/home_page.dart';
import 'package:oech_app/onboarding/presentation/pages/onboarding_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/presentation/pages/signup_page.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: "https://feyqfihsyhchwsjseqsg.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZleXFmaWhzeWhjaHdzanNlcXNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODc4ODQ0NjQsImV4cCI6MjAwMzQ2MDQ2NH0.iIjNJGoJ08Gyqo8C1OHG3nHw7CtNRFtGmcLQq10qTxo");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final supabase = Supabase.instance.client;

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
              if (value[0] && !value[1] && !(supabase.auth.currentUser != null && supabase.auth.currentUser?.appMetadata["provider"] != "email")) {
                return SignupPage();
              }
              else if(value[1] || supabase.auth.currentUser != null) {
                return HomePage();
              }
              return const OnboardingPage();
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
                )));
  }
}
