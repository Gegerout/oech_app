import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/data/repository/data_repository.dart';

import '../../data/models/user_model.dart';

final signinProvider = ChangeNotifierProvider((ref) => signinNotifier());

class signinNotifier extends ChangeNotifier {
  bool isEmail = false;
  bool isShown = true;
  bool isChecked = false;

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

  Future<UserModel?> loginUser(String email, String password) async {
    final data = await DataRepository().loginUser(email, password, isChecked);
    if(data != null) {
      return data.data;
    }
    return null;
  }

  Future<void> loginUserGoogle() async {
    await DataRepository().loginUserGoogle();
  }
}