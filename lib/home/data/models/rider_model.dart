class RiderModel {
  final String avatar;
  final String name;
  final String regNum;
  final String rate;
  final List<dynamic>? feedbacks;
  final String gender;
  final String car;
  final String phone;

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(json["avatar"], json["name"], json["reg_num"],
        json["rate"], json["gender"], json["car"], json["phone"], feedbacks: json["feedbacks"]);
  }

  RiderModel(this.avatar, this.name, this.regNum, this.rate,
      this.gender, this.car, this.phone, {this.feedbacks});

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "name": name,
    "regNum": regNum,
    "rate": rate,
    "feedbacks": feedbacks,
    "gender": gender,
    "car": car,
    "phone": phone
  };
}
