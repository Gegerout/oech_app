import 'dart:convert';
import 'dart:io';
import 'package:oech_app/auth/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {
  Future<UserModel?> getUser() async {
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/userData.json");
    if(file.existsSync()) {
      final model = UserModel.fromJson(json.decode(file.readAsStringSync()));
      return model;
    }
    return null;
  }

  Future<bool> getShowed() async {
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/onbData.json");
    if(file.existsSync()) {
      if(file.readAsStringSync() == "true") return true;
    }
    return false;
  }
}