class ImagesModel {
  final String image;
  final String? title;

   factory ImagesModel.fromJson(Map<String, dynamic> json) {
       return ImagesModel(json["url"], json["title"]);
   }

  ImagesModel(this.image, this.title);
}