// To parse this JSON data, do
//
//     final businessMongoModels = businessMongoModelsFromJson(jsonString);

import 'dart:convert';

BusinessMongoModels businessMongoModelsFromJson(String str) => BusinessMongoModels.fromJson(json.decode(str));

String businessMongoModelsToJson(BusinessMongoModels data) => json.encode(data.toJson());

class BusinessMongoModels {
    List<String> amenities;
    String businessUid;
    List<String> images;
    List<OpeningHour> openingHours;

    BusinessMongoModels({
        required this.amenities,
        required this.businessUid,
        required this.images,
        required this.openingHours,
    });

    factory BusinessMongoModels.fromJson(Map<String, dynamic> json) => BusinessMongoModels(
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        businessUid: json["business_uid"],
        images: List<String>.from(json["images"].map((x) => x)),
        openingHours: List<OpeningHour>.from(json["opening_hours"].map((x) => OpeningHour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "business_uid": businessUid,
        "images": List<dynamic>.from(images.map((x) => x)),
        "opening_hours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
    };
}

class OpeningHour {
    String day;
    String openingHours;

    OpeningHour({
        required this.day,
        required this.openingHours,
    });

    factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
        day: json["day"],
        openingHours: json["openingHours"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "openingHours": openingHours,
    };
}
