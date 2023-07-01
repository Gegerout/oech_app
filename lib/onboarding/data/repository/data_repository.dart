import 'package:oech_app/onboarding/data/data_sources/local_data.dart';
import 'package:oech_app/onboarding/domain/repository/repository_impl.dart';
import 'package:oech_app/onboarding/domain/usecases/onboarding_usecase.dart';

class DataRepository extends Repository {
  @override
  Future<OnboardingUseCase> getOnboarding() async {
    final data = await LocalData().getOnboarding();
    final usecase = OnboardingUseCase(data);
    return usecase;
  }

  @override
  Future<void> saveShowed() async {
    await LocalData().saveShowed();
  }
}