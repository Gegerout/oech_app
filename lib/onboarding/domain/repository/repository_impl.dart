import '../usecases/onboarding_usecase.dart';

abstract class Repository {
  Future<OnboardingUseCase> getOnboarding();
  Future<void> saveShowed();
  Future<bool> getShowed();
}