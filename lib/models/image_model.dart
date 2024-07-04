class ImageModel {
  final String imageUrl;
  final String displaySiteName;

  ImageModel({required this.imageUrl, required this.displaySiteName});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['image_url'],
      displaySiteName: json['display_sitename'],
    );
  }
}