import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/home/data/models/rider_model.dart';
import '../../data/repository/data_repository.dart';

final callProvider = FutureProvider.family<RiderModel, String>((ref, regNum) async {
  final data = await DataRepository().gerRider(regNum);
  return data;
});
