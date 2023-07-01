import 'package:oech_app/home/data/data_sources/remote_data.dart';
import 'package:oech_app/home/domain/usecases/images_usecase.dart';

import '../../domain/repository/repository_impl.dart';

class DataRepository extends Repository {
  @override
  Future<ImagesUseCase> getImages() async {
    final data = await RemoteData().getImages();
    final usecase = ImagesUseCase(data);
    return usecase;
  }
}