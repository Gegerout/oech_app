import '../usecases/images_usecase.dart';

abstract class Repository {
  Future<ImagesUseCase> getImages();
}