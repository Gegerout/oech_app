class UserModel {
  final String name;
  final String phone;
  final String email;
  final String balance;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json["name"], json["phone"], json["email"], json["balance"]);
  }

  UserModel(this.name, this.phone, this.email, this.balance);

  Map<String, dynamic> toJson() =>
      {"name": name, "phone": phone, "email": email, "balance": balance};
}
