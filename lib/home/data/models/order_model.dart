class OrderModel {
  final List<dynamic> origins;
  final List destinations;
  final List<dynamic> packages;
  final String email;
  final String track;

   factory OrderModel.fromJson(Map<String, dynamic> json) {
       return OrderModel(json["origins"], json["destinations"], json["packages"], json["email"], json["track"]);
   }

  OrderModel(this.origins, this.destinations, this.packages, this.email, this.track);

   Map<String, dynamic> toJson() => {
     "origins": origins,
     "destinations": destinations,
     "packages": packages,
     "email": email,
     "track": track
   };
}