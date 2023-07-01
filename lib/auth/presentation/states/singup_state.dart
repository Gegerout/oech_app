import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/data/models/user_model.dart';
import 'package:oech_app/auth/data/repository/data_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final signupProvider = ChangeNotifierProvider((ref) => signupNotifier());

class signupNotifier extends ChangeNotifier {
  bool isEmail = false;
  bool isShown = true;
  bool isChecked = false;
  bool isLogged = false;

  void checkEmail(String email) {
    if(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      isEmail = true;
    }
    else {
      isEmail = false;
    }
    notifyListeners();
  }

  void changeShown() {
    isShown = !isShown;
    notifyListeners();
  }

  void changeChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  Future<User?> signupUser(String name, String phone, String email, String password) async {
    final data = await DataRepository().signupUser(name, phone, email, password);
    return data;
  }

  Future<void> loginUserGoogle() async {
    await DataRepository().loginUserGoogle();
  }
}