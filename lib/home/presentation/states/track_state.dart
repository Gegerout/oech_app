import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oech_app/home/data/models/order_model.dart';
import 'package:oech_app/home/data/repository/data_repository.dart';

final positionProvider = FutureProvider.family<(Position, OrderModel), String>((ref, track) async {
  final data = await DataRepository().getOrderDetails(track);
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return (position, data.data);
});

final trackProvider = ChangeNotifierProvider((ref) => trackNotifier());

class trackNotifier extends ChangeNotifier {
  void setOrderState(List data, String track) async {
    await DataRepository().setOrderState(data, track);
  }
}