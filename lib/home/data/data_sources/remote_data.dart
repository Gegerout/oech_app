import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/images_model.dart';

class RemoteData {
  Future<List<ImagesModel>> getImages() async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from("asset_images").select("*").order("id", ascending: true);
    final models = (data as List).map((e) => ImagesModel.fromJson(e)).toList();
    return models;
  }
}