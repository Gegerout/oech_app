import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oech_app/home/data/models/order_model.dart';
import 'package:oech_app/home/data/repository/data_repository.dart';

final positionProvider = FutureProvider.family<(Position, OrderModel, List<LatLng>), String>((ref, track) async {
  final data = await DataRepository().getOrderDetails(track);
  List<LatLng> routpoints = [];
  LocationPermission isPermission = await Geolocator.checkPermission();
  if(isPermission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var url = Uri.parse('http://router.project-osrm.org/route/v1/driving/${position.longitude},${position.latitude};${position.longitude + 0.01},${position.latitude + 0.01}?steps=true&annotations=true&geometries=geojson&overview=full');
  var response = await http.get(url);
  var ruter = jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
  for(int i=0; i< ruter.length; i++){
    var reep = ruter[i].toString();
    reep = reep.replaceAll("[","");
    reep = reep.replaceAll("]","");
    var lat1 = reep.split(',');
    var long1 = reep.split(",");
    routpoints.add(LatLng( double.parse(lat1[1]), double.parse(long1[0])));
  }
  return (position, data.data, routpoints);
});

final trackProvider = ChangeNotifierProvider((ref) => trackNotifier());

class trackNotifier extends ChangeNotifier {
  void setOrderState(List data, String track) async {
    await DataRepository().setOrderState(data, track);
  }
}