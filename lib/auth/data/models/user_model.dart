import 'package:crypto/crypto.dart';

class UserModel {
  final String name;
  final String phone;
  final String email;
  final String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json["name"], json["phone"], json["email"], json["password"]);
  }

  UserModel(this.name, this.phone, this.email, this.password);

  Map<String, dynamic> toJson() =>
      {"name": name, "phone": phone, "email": email, "password": password};
}
