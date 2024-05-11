// To parse this JSON data, do
//
//     final servicesModels = servicesModelsFromJson(jsonString);

import 'dart:convert';

ServicesModels servicesModelsFromJson(String str) =>
    ServicesModels.fromJson(json.decode(str));

String servicesModelsToJson(ServicesModels data) => json.encode(data.toJson());

class ServicesModels {
  List<String>? amenities;
  String businessUid;
  List<String>? images;
  List<OpeningHour>? openingHours;

  ServicesModels({
    this.amenities,
    required this.businessUid,
    this.images,
    this.openingHours,
  });

  // factory ServicesModels.fromJson(Map<String, dynamic> json) => ServicesModels(
  //     amenities: List<String>.from(json["amenities"].map((x) => x)),
  //     businessUid: json["business_uid"],
  //     images: List<String>.from(json["images"].map((x) => x)),
  //     openingHours: List<OpeningHour>.from(json["opening_hours"].map((x) => OpeningHour.fromJson(x))),
  // );
  factory ServicesModels.fromJson(Map<String, dynamic> json) {
  return ServicesModels(
    amenities: json["amenities"] != null ? List<String>.from(json["amenities"].map((x) => x)) : null,
    businessUid: json["business_uid"],
    images:json["images"] !=null ? List<String>.from(json["images"].map((x) => x)) : null,
    openingHours: json["opening_hours"] != null
        ? List<OpeningHour>.from(
            json["opening_hours"].map((x) => OpeningHour.fromJson(x)))
        : null,
  );
}

// amenities: json["amenities"] != null
//     ? List<String>.from(json["amenities"].map((x) => x))
//     : null,
// images: json["images"] != null
//     ? List<String>.from(json["images"].map((x) => x))
//     : null,
// openingHours: json["opening_hours"] != null
//     ? List<OpeningHour>.from(
//         json["opening_hours"].map((x) => OpeningHour.fromJson(x)))
//     : null,






  Map<String, dynamic> toJson() => {
        "amenities": List<dynamic>.from(amenities!.map((x) => x)),
        "business_uid": businessUid,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "opening_hours":
            List<dynamic>.from(openingHours!.map((x) => x.toJson())),
      };
}

class OpeningHour {
  String? day;
  List<OpeningTime>? openingTime;

  OpeningHour({
    this.day,
    this.openingTime,
  });

  // factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
  //       day: json["day"],
  //       openingTime: List<OpeningTime>.from(
  //           json["opening_time"].map((x) => OpeningTime.fromJson(x))),
  //     );
      factory OpeningHour.fromJson(Map<String, dynamic> json) {
  return OpeningHour(
    day: json["day"],
    openingTime: json["opening_time"] != null
        ? List<OpeningTime>.from(
            json["opening_time"].map((x) => OpeningTime.fromJson(x)))
        : null,
  );
}




  Map<String, dynamic> toJson() => {
        "day": day,
        "opening_time": List<dynamic>.from(openingTime!.map((x) => x.toJson())),
      };
}

class OpeningTime {
  String? endTime;
  String? startTime;

  OpeningTime({
    this.endTime,
    this.startTime,
  });

  factory OpeningTime.fromJson(Map<String, dynamic> json) => OpeningTime(
        endTime: json["endTime"],
        startTime: json["startTime"],
      );

  Map<String, dynamic> toJson() => {
        "endTime": endTime,
        "startTime": startTime,
      };
}
