import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final profileProvider = FutureProvider((ref) async {
  ref.read(profileDataProvider.notifier).updateBalance("N10,712:00");
  final data = await DataRepository().getUserData();
  return data.data;
});

final profileDataProvider = ChangeNotifierProvider((ref) => profileDataNotifier());

class profileDataNotifier extends ChangeNotifier {
  bool isShowed = true;

  void updateBalance(String balance) async {
    await DataRepository().updateBalance(balance);
  }

  void changeShowed() {
    isShowed = !isShowed;
    notifyListeners();
  }

  Future<void> logout() async {
    await DataRepository().logout();
  }
}