import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:oech_app/auth/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteData {
  Future<User?> signupUser(
      String name, String phone, String email, String password) async {
    final supabase = Supabase.instance.client;
    try {
      final AuthResponse res =
          await supabase.auth.signUp(email: email, password: password, data: {
            "name": name,
            "phone": phone
          },);
      await supabase
          .from("users")
          .insert({"name": name, "phone": phone, "email": email});
      final User? user = res.user;
      return user;
    } on AuthException {
      return null;
    }
  }

  Future<void> loginUserGoogle() async {
    final supabase = Supabase.instance.client;
    final res = await supabase.auth.getOAuthSignInUrl(
      provider: Provider.google,
      queryParams: {
        "access_type": 'offline',
        "prompt": 'consent',
      },
    );
    await launch(res.url!);
  }

  Future<void> saveUser() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    final List<dynamic> mail =
    await supabase.from("users").select("email").eq("email", user!.email);
    if(mail.isEmpty) {
      await supabase
          .from("users")
          .insert({"name": user.userMetadata?["name"], "phone": user.phone, "email": user.email});
      final model =
      UserModel(user.userMetadata?["name"], user.phone.toString() ?? "", user.email!, null);
      file.writeAsStringSync(json.encode(model));
    }
  }

  Future<UserModel?> loginUser(
      String email, String password, bool isPass) async {
    final supabase = Supabase.instance.client;
    try {
      final AuthResponse res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      var dir = await getTemporaryDirectory();
      final File file = File("${dir.path}/userData.json");

      if (isPass) {
        var bytes = utf8.encode(password);
        final code = sha512.convert(bytes);
        final name =
            await supabase.from("users").select("name").eq("email", email);
        final phone =
            await supabase.from("users").select("phone").eq("email", email);
        final model = UserModel(
            name[0]["name"], phone[0]["phone"].toString(), email.toString(), code.toString());
        file.writeAsStringSync(json.encode(model));
        return model;
      } else {
        final name =
            await supabase.from("users").select("name").eq("email", email);
        final phone =
            await supabase.from("users").select("phone").eq("email", email);
        final model = UserModel(
            name[0]["name"], phone[0]["phone"].toString(), email.toString(), null);
        file.writeAsStringSync(json.encode(model));
        return model;
      }
    } on AuthException {
      return null;
    }
  }

  Future<void> sendOtp(String email) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<bool> checkOtp(String email, String code) async {
    final supabase = Supabase.instance.client;
    try {
      final data = await supabase.auth
          .verifyOTP(token: code, type: OtpType.recovery, email: email);
      if (data.user != null) {
        saveUser();
        return true;
      } else {
        return false;
      }
    } on AuthException {
      return false;
    }
  }

  Future<bool> updateUser(String password) async {
    final supabase = Supabase.instance.client;
    try {
      final data =
          await supabase.auth.updateUser(UserAttributes(password: password));
      if (data.user != null) {
        return true;
      }
      return false;
    } on AuthException {
      return false;
    }
  }
}
