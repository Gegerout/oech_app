import 'package:flutter/material.dart';
import 'package:oech_app/home/presentation/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(0)), (route) => false);
        });
      }
    });

    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            if(isLoading) {
              return const CircularProgressIndicator();
            }
            return Container();
          },
        ),
      )
    );
  }
}
