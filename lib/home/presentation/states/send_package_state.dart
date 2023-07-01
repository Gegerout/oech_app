import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/data/models/order_model.dart';
import 'package:oech_app/home/data/repository/data_repository.dart';
import 'package:oech_app/home/domain/usecases/order_usecase.dart';

final sendPackageProvider =
    ChangeNotifierProvider((ref) => sendPackageNotifier());

class sendPackageNotifier extends ChangeNotifier {
  int count = 1;
  int currentIndex = 3;
  bool isValid = false;
  List data = [
    [
      "assets/images/clock_icon.png",
      "assets/images/clock_active.png",
      "Instant delivery"
    ],
    [
      "assets/images/schedule_icon.png",
      "assets/images/schedule_active.png",
      "Scheduled delivery"
    ]
  ];

  void addCount() {
    count += 1;
    notifyListeners();
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void createOrder(
      String address1,
      String state1,
      String phone1,
      String address2,
      String state2,
      String phone2,
      String items,
      String weight,
      String worth,
      String email, String track) async {
    final model = OrderModel([address1, state1, phone1],
        [address2, state2, phone2], [items, weight, worth], email, track);
    final usecase = OrderUseCase(model);
    await DataRepository().createOrder(usecase);
  }

  void checkCreds(
    String address1,
    String state1,
    String phone1,
    String address2,
    String state2,
    String phone2,
    String items,
    String weight,
    String worth,
  ) {
    isValid = address1.isNotEmpty &&
        address2.isNotEmpty &&
        state1.isNotEmpty &&
        state2.isNotEmpty &&
        phone1.isNotEmpty &&
        phone2.isNotEmpty &&
        items.isNotEmpty &&
        weight.isNotEmpty &&
        worth.isNotEmpty;
    notifyListeners();
  }
}

final orderProvider =
    FutureProvider.family<OrderModel, String>((ref, track) async {
  final data = await DataRepository().getOrder(track);
  return data.data;
});
