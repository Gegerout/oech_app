import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/onboarding_model.dart';

class LocalData {
  Future<List<OnboardingModel>> getOnboarding() async {
    final file = await rootBundle.loadString("assets/json/onb_data.json");
    final data = await json.decode(file);
    final models = (data["data"] as List).map((e) => OnboardingModel.fromJson(e)).toList();
    return models;
  }
  Future<void> saveShowed() async {
    var dir = await getTemporaryDirectory();
    final File file = File("${dir.path}/onbData.json");
    file.writeAsStringSync("true");
  }
}