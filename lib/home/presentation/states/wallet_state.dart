import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final walletProvider = FutureProvider((ref) async {
  final transactions = [
    ["Delivery fee", "July 7, 2022", "-N3,000.00"],
    ["Delivery fee", "July 7, 2022", "-N2,000.00"],
    ["Top up", "July 28, 2022", "N10,000.00"],
    ["Delivery fee", "July 25, 2022", "-N2,000.00"],
    ["Top up", "July 25, 2022", "N5,000.00"],
    ["Delivery fee", "July 17, 2022", "-N4,000.00"],
    ["Delivery fee", "July 10, 2022", "-N12,000.00"],
    ["Delivery fee", "July 7, 2022", "-N2,000.00"],
    ["Top up", "July 7, 2022", "N20,000.00"],
    ["Top up", "July 7, 2022", "N20,000.00"],
    ["Delivery fee", "July 4, 2022", "-N15,000.00"],
    ["Top up", "July 4, 2022", "N20,000.00"],
    ["Delivery fee", "July 2, 2022", "-N3,000.00"],
    ["Top up", "July 2, 2022", "N5,000.00"]
  ];
  ref.read(walletDataProvider.notifier).createTransactions(transactions);
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