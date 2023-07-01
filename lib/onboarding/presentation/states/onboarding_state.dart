import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/data_repository.dart';

final onboardingProvider = FutureProvider((ref) async {
  final data = await DataRepository().getOnboarding();
  final models = data.data;
  return models;
});

final onboardingStateProvider = ChangeNotifierProvider((ref) =>
    OnboardingStateNotifier());

class OnboardingStateNotifier extends ChangeNotifier {
  int index = 0;

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  void saveShowed() async {
    await DataRepository().saveShowed();
  }
}