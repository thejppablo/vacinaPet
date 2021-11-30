import 'dart:convert';

JobCreateRequestModel jobCreateRequestModelFromJson(String str) => JobCreateRequestModel.fromJson(json.decode(str));

String jobCreateRequestModelToJson(JobCreateRequestModel data) => json.encode(data.toJson());

class JobCreateRequestModel {
  JobCreateRequestModel({
    required this.category,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.images,
  });

  String category;
  String title;
  String description;
  String latitude;
  String longitude;
  List<Image> images;

  factory JobCreateRequestModel.fromJson(Map<String, dynamic> json) => JobCreateRequestModel(
    category: json["category"],
    title: json["title"],
    description: json["description"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "title": title,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.size,
    required this.uploadedAt,
  });

  String id;
  String name;
  String type;
  String url;
  String size;
  String uploadedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    url: json["url"],
    size: json["size"],
    uploadedAt: json["uploadedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "url": url,
    "size": size,
    "uploadedAt": uploadedAt,
  };
}
