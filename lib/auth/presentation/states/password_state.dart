import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final passwordProvider = ChangeNotifierProvider((ref) => passwordNotifier());

class passwordNotifier extends ChangeNotifier {
  bool isEmail = false;

  void checkEmail(String email) {
    if(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      isEmail = true;
    }
    else {
      isEmail = false;
    }
    notifyListeners();
  }

  Future<void> sendOtp(String email) async {
    await DataRepository().sendOtp(email);
  }

  Future<bool> checkOtp(String email, String code) async {
    final data = await DataRepository().checkOtp(email, code);
    return data;
  }

  Future<bool> updateUser(String password) async {
    final data = await DataRepository().updateUser(password);
    return data;
  }
}