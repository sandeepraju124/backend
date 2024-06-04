// // To parse this JSON data, do
// //
// //     final servicesModels = servicesModelsFromJson(jsonString);

// import 'dart:convert';

// ServicesModels servicesModelsFromJson(String str) =>
//     ServicesModels.fromJson(json.decode(str));

// String servicesModelsToJson(ServicesModels data) => json.encode(data.toJson());

// class ServicesModels {
//   List<String>? amenities;
//   String businessUid;
//   List<String>? images;
//   List<OpeningHour>? openingHours;

//   ServicesModels({
//     this.amenities,
//     required this.businessUid,
//     this.images,
//     this.openingHours,
//   });

//   factory ServicesModels.fromJson(Map<String, dynamic> json) {
//   return ServicesModels(
//     amenities: json["amenities"] != null ? List<String>.from(json["amenities"].map((x) => x)) : null,
//     businessUid: json["business_uid"],
//     images:json["images"] !=null ? List<String>.from(json["images"].map((x) => x)) : null,
//     openingHours: json["opening_hours"] != null
//         ? List<OpeningHour>.from(
//             json["opening_hours"].map((x) => OpeningHour.fromJson(x)))
//         : null,
//   );
// }


//   Map<String, dynamic> toJson() => {
//         "amenities": List<dynamic>.from(amenities!.map((x) => x)),
//         "business_uid": businessUid,
//         "images": List<dynamic>.from(images!.map((x) => x)),
//         "opening_hours":
//             List<dynamic>.from(openingHours!.map((x) => x.toJson())),
//       };
// }

// class OpeningHour {
//   String? day;
//   List<OpeningTime>? openingTime;

//   OpeningHour({
//     this.day,
//     this.openingTime,
//   });

//       factory OpeningHour.fromJson(Map<String, dynamic> json) {
//   return OpeningHour(
//     day: json["day"],
//     openingTime: json["opening_time"] != null
//         ? List<OpeningTime>.from(
//             json["opening_time"].map((x) => OpeningTime.fromJson(x)))
//         : null,
//   );
// }




//   Map<String, dynamic> toJson() => {
//         "day": day,
//         "opening_time": List<dynamic>.from(openingTime!.map((x) => x.toJson())),
//       };
// }

// class OpeningTime {
//   String? endTime;
//   String? startTime;

//   OpeningTime({
//     this.endTime,
//     this.startTime,
//   });

//   factory OpeningTime.fromJson(Map<String, dynamic> json) => OpeningTime(
//         endTime: json["endTime"],
//         startTime: json["startTime"],
//       );

//   Map<String, dynamic> toJson() => {
//         "endTime": endTime,
//         "startTime": startTime,
//       };
// }


// To parse this JSON data, do
//
//     final servicesModels = servicesModelsFromJson(jsonString);

import 'dart:convert';

ServicesModels servicesModelsFromJson(String str) => ServicesModels.fromJson(json.decode(str));

String servicesModelsToJson(ServicesModels data) => json.encode(data.toJson());

class ServicesModels {

    List<String>? amenities;
    String businessUid;
    List<String>? images;
    OperatingHours? operatingHours;

    ServicesModels({

    this.amenities,
    required this.businessUid,
    this.images,
    this.operatingHours,
    });

    factory ServicesModels.fromJson(Map<String, dynamic> json) => ServicesModels(
        amenities: json["amenities"] != null ? List<String>.from(json["amenities"].map((x) => x)) : null,
    businessUid: json["business_uid"],
    images:json["images"] !=null ? List<String>.from(json["images"].map((x) => x)) : null,
    // openingHours: json["opening_hours"] != null
    //     ? List<OpeningHour>.from(
    //         json["opening_hours"].map((x) => OpeningHour.fromJson(x)))
    //     : null,
        operatingHours: OperatingHours.fromJson(json["operating_hours"]),
    );

    Map<String, dynamic> toJson() => {
        "amenities": List<dynamic>.from(amenities!.map((x) => x)),
        "business_uid": businessUid,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "operating_hours": operatingHours!.toJson(),
    };
}

class OperatingHours {
  Day friday;
  Day monday;
  Day thursday;
  Day tuesday;
  Day wednesday;

  OperatingHours({
    required this.friday,
    required this.monday,
    required this.thursday,
    required this.tuesday,
    required this.wednesday,
  });

  factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
    friday: Day.fromJson(json["Friday"]),
    monday: Day.fromJson(json["Monday"]),
    thursday: Day.fromJson(json["Thursday"]),
    tuesday: Day.fromJson(json["Tuesday"]),
    wednesday: Day.fromJson(json["Wednesday"]),
  );

  Map<String, dynamic> toJson() => {
    "Friday": friday.toJson(),
    "Monday": monday.toJson(),
    "Thursday": thursday.toJson(),
    "Tuesday": tuesday.toJson(),
    "Wednesday": wednesday.toJson(),
  };

  // Method to convert OperatingHours to Map<String, Map<String, dynamic>>
  Map<String, Map<String, dynamic>> toMap() {
    return {
      "Friday": friday.toMap(),
      "Monday": monday.toMap(),
      "Thursday": thursday.toMap(),
      "Tuesday": tuesday.toMap(),
      "Wednesday": wednesday.toMap(),
    };
  }
}

class Day {
  dynamic close;
  bool closed;
  dynamic open;
  bool open24;

  Day({
    required this.close,
    required this.closed,
    required this.open,
    required this.open24,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    close: json["close"],
    closed: json["closed"],
    open: json["open"],
    open24: json["open24"],
  );

  Map<String, dynamic> toJson() => {
    "close": close,
    "closed": closed,
    "open": open,
    "open24": open24,
  };

  Map<String, dynamic> toMap() => {
    "close": close,
    "closed": closed,
    "open": open,
    "open24": open24,
  };
}

