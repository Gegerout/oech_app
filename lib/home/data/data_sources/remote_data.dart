import 'dart:io';

import 'package:oech_app/home/data/models/order_model.dart';
import 'package:oech_app/home/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/images_model.dart';

class RemoteData {
  Future<List<ImagesModel>> getImages() async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from("asset_images")
        .select("*")
        .order("id", ascending: true);
    final models = (data as List).map((e) => ImagesModel.fromJson(e)).toList();
    return models;
  }

  Future<UserModel> getUserData() async {
    final supabase = Supabase.instance.client;
    final name = await supabase
        .from("users")
        .select("name")
        .eq("email", supabase.auth.currentUser?.email);
    final phone = await supabase
        .from("users")
        .select("phone")
        .eq("email", supabase.auth.currentUser?.email);
    final balance = await supabase
        .from("users")
        .select("balance")
        .eq("email", supabase.auth.currentUser?.email);
    final model = UserModel(name[0]["name"], phone[0]["phone"],
        supabase.auth.currentUser!.email!, balance[0]["balance"]);
    return model;
  }

  Future<void> updateBalance(String balance) async {
    final supabase = Supabase.instance.client;
    await supabase.from("users").update({"balance": balance}).eq(
        "email", supabase.auth.currentUser!.email);
  }

  Future<void> logout() async {
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    if(file.existsSync()) {
      file.deleteSync();
    }
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
  }

  Future<void> createOrder(OrderModel data) async {
    final supabase = Supabase.instance.client;
    final List isDone =
        await supabase.from("orders").select("track").eq("track", data.track);
    if (isDone.isNotEmpty) {
      await supabase.from("orders").update({
        "origin_details": data.origins,
        "destination_details": data.destinations,
        "package_details": data.packages,
        "email": data.email,
        "track": data.track
      }).eq("track", data.track);
    } else {
      await supabase.from("orders").insert({
        "origin_details": data.origins,
        "destination_details": data.destinations,
        "package_details": data.packages,
        "email": data.email,
        "track": data.track
      });
    }
  }

  Future<OrderModel> getOrder(String track) async {
    final supabase = Supabase.instance.client;
    List origins = [];
    origins = await supabase
        .from("orders")
        .select("origin_details")
        .eq("track", track);
    while (origins.isEmpty) {
      origins = await supabase
          .from("orders")
          .select("origin_details")
          .eq("track", track);
    }
    final destinations = await supabase
        .from("orders")
        .select("destination_details")
        .eq("track", track);
    final packages = await supabase
        .from("orders")
        .select("package_details")
        .eq("track", track);
    final model = OrderModel(
        origins[0]["origin_details"],
        destinations[0]["destination_details"],
        packages[0]["package_details"],
        supabase.auth.currentUser!.email!,
        track);
    return model;
  }
}
