class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(json["title"], json["subtitle"], json["image"]);
  }

  OnboardingModel(this.title, this.subtitle, this.image);
}
