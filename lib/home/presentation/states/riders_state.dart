import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oech_app/home/data/models/rider_model.dart';
import '../../data/repository/data_repository.dart';

final getRidersProvider =
    FutureProvider.family<List<RiderModel>, String>((ref, prompt) async {
  final data = ref.read(ridersProvider.notifier).searchRiders(prompt);
  return data;
});

final getRiderProfileProvider = FutureProvider.family<(Position, RiderModel), String>((ref, regNum) async {
  final data = await DataRepository().gerRider(regNum);
  List<LatLng> routpoints = [];
  LocationPermission permission = await Geolocator.requestPermission();
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return (position, data);
});

final ridersProvider = ChangeNotifierProvider((ref) => ridersNotifier());

class ridersNotifier extends ChangeNotifier {
  List<RiderModel> data = [];
  bool isColor = false;
  bool isAll = false;

  Future<List<RiderModel>> getRiders() async {
    final usecase = await DataRepository().getRiders();
    data = usecase.data;
    notifyListeners();
    return usecase.data;
  }

  Future<List<RiderModel>> searchRiders(String prompt) async {
    final usecase = await DataRepository().getRiders();
    final models = usecase.data;
    List<RiderModel> newData = [];
    for (int i = 0; i < models.length; i++) {
      if (models[i].name.toLowerCase().contains(prompt) ||
          models[i].regNum.toLowerCase().contains(prompt)) {
        newData.add(models[i]);
      }
    }
    data = newData;
    notifyListeners();
    return newData;
  }

  void changeFocus(bool focus) async {
    isColor = focus;
  }

  void changeView() {
    isAll = true;
    notifyListeners();
  }
}
