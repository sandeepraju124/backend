// To parse this JSON data, do
//
//     final servicesModels = servicesModelsFromJson(jsonString);

import 'dart:convert';

ServicesModels servicesModelsFromJson(String str) => ServicesModels.fromJson(json.decode(str));

String servicesModelsToJson(ServicesModels data) => json.encode(data.toJson());

class ServicesModels {
    List<String> amenities;
    String businessUid;
    List<String> images;
    List<ServicesModelsOpeningHour> openingHours;

    ServicesModels({
        required this.amenities,
        required this.businessUid,
        required this.images,
        required this.openingHours,
    });

    factory ServicesModels.fromJson(Map<String, dynamic> json) => ServicesModels(
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        businessUid: json["business_uid"],
        images: List<String>.from(json["images"].map((x) => x)),
        openingHours: List<ServicesModelsOpeningHour>.from(json["opening_hours"].map((x) => ServicesModelsOpeningHour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "business_uid": businessUid,
        "images": List<dynamic>.from(images.map((x) => x)),
        "opening_hours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
    };
}

class ServicesModelsOpeningHour {
    String day;
    List<OpeningHourOpeningHour> openingHours;

    ServicesModelsOpeningHour({
        required this.day,
        required this.openingHours,
    });

    factory ServicesModelsOpeningHour.fromJson(Map<String, dynamic> json) => ServicesModelsOpeningHour(
        day: json["day"],
        openingHours: List<OpeningHourOpeningHour>.from(json["opening_hours"].map((x) => OpeningHourOpeningHour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "opening_hours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
    };
}

class OpeningHourOpeningHour {
    String endTime;
    String startTime;

    OpeningHourOpeningHour({
        required this.endTime,
        required this.startTime,
    });

    factory OpeningHourOpeningHour.fromJson(Map<String, dynamic> json) => OpeningHourOpeningHour(
        endTime: json["endTime"],
        startTime: json["startTime"],
    );

    Map<String, dynamic> toJson() => {
        "endTime": endTime,
        "startTime": startTime,
    };
}
