import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final walletProvider = FutureProvider((ref) async {
  final data = await DataRepository().getUserData();
  return data.data;
});

final walletDataProvider = ChangeNotifierProvider((ref) => walletDataNotifier());

class walletDataNotifier extends ChangeNotifier {
  bool isShowed = true;

  void changeShowed() {
    isShowed = !isShowed;
    notifyListeners();
  }

  void createTransactions(List data) async {
    await DataRepository().createTransaction(data);
  }
}