import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/data/models/rider_model.dart';

import '../../data/repository/data_repository.dart';

final chatProvider = FutureProvider.family<RiderModel, String>((ref, regNum) async {
  final data = await DataRepository().gerRider(regNum);
  return data;
});

final chatDataProvider = ChangeNotifierProvider((ref) => chatDataNotifier());

class chatDataNotifier extends ChangeNotifier {
  bool isColor = false;

  void changeFocus(bool focus) async {
    isColor = focus;
    notifyListeners();
  }
}