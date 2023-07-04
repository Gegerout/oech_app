import 'package:gotrue/src/types/user.dart';
import 'package:oech_app/auth/data/data_sources/local_data.dart';
import 'package:oech_app/auth/data/data_sources/remote_data.dart';
import 'package:oech_app/auth/data/models/user_model.dart';
import 'package:oech_app/auth/domain/repository/repository_impl.dart';
import 'package:oech_app/auth/domain/usecases/user_usecase.dart';

class DataRepository extends Repository {
  @override
  Future<User?> signupUser(String name, String phone, String email, String password) async {
    final data = await RemoteData().signupUser(name, phone, email, password);
    return data;
  }

  @override
  Future<UserUseCase?> loginUser(String email, String password, bool isPass) async {
    final data = await RemoteData().loginUser(email, password, isPass);
    if(data != null) {
      final usecase = UserUseCase(data);
      return usecase;
    }
    return null;
  }

  @override
  Future<void> loginUserGoogle() async {
    await RemoteData().loginUserGoogle();
  }

  @override
  Future<void> sendOtp(String email) async {
    await RemoteData().sendOtp(email);
  }

  @override
  Future<bool> checkOtp(String email, String code) async {
    final data = await RemoteData().checkOtp(email, code);
    return data;
  }

  @override
  Future<bool> updateUser(String password) async {
    final data = await RemoteData().updateUser(password);
    return data;
  }

  @override
  Future<UserModel?> getUser() async {
    final data = await LocalData().getUser();
    return data;
  }

  @override
  Future<bool> getShowed() async {
    final data = await LocalData().getShowed();
    return data;
  }

  @override
  Future<void> saveUser() async {
    await RemoteData().saveUser();
  }
}