import 'package:oech_app/auth/data/models/user_model.dart';
import 'package:oech_app/auth/domain/usecases/user_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Repository {
  Future<User?> signupUser(String name, String phone, String email, String password);
  Future<UserUseCase?> loginUser(String email, String password, bool isPass);
  Future<void> loginUserGoogle();
  Future<void> saveUser();
  Future<void> sendOtp(String email);
  Future<bool> checkOtp(String email, String code);
  Future<bool> updateUser(String password);
  Future<UserModel?> getUser();
  Future<bool> getShowed();
}