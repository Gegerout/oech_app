import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/data/repository/data_repository.dart';

final mainProvider = FutureProvider((ref) async {
  final res = [];
  final data1 = await DataRepository().getShowed();
  final data2 = await DataRepository().getUser();
  res.add(data1);
  if(data2 != null) {
   res.add(true);
  }
  else {
    res.add(false);
  }
  return res;
});

final userProvider = ChangeNotifierProvider((ref) => userNotifier());

class userNotifier extends ChangeNotifier {
  void saveUser() async {
    await DataRepository().saveUser();
  }
}

final themeProvider = ChangeNotifierProvider((ref) => themeNotifier());

class themeNotifier extends ChangeNotifier {
  bool darkMode = false;

  void changeTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }
}