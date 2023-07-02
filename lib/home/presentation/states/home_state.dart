import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final imagesProvider = FutureProvider((ref) async {
  ref.read(homeProvider.notifier).getOrders();
  final data = await DataRepository().getImages();
  return data.data;
});

final homeProvider = ChangeNotifierProvider((ref) => homeNotifier());

class homeNotifier extends ChangeNotifier {
  List orders = [];

  List data = [
    [
      "Customer Care",
      "Our customer care service line is available from 8 -9pm week days and 9 - 5 weekends - tap to call us today",
      "assets/images/person_blue.png",
      "assets/images/person_white.png"
    ],
    [
      "Send a package",
      "Request for a driver to pick up or deliver your package for you",
      "assets/images/package_blue.png",
      "assets/images/package_white.png"
    ],
    [
      "Fund your wallet",
      "To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today",
      "assets/images/wallet_blue.png",
      "assets/images/wallet_white.png"
    ],
    [
      "Book a rider",
      "Search for available rider within your area",
      "assets/images/car_blue.png",
      "assets/images/car_white.png"
    ]
  ];

  void getOrders() async {
    final data = await DataRepository().getOrders();
    orders = data;
    notifyListeners();
  }
}
