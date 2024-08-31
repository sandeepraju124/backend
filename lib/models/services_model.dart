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
        // operatingHours: OperatingHours.fromJson(json["operating_hours"]),
         operatingHours: json["operating_hours"] != null ? OperatingHours.fromJson(json["operating_hours"]) : null,
    );



    Map<String, dynamic> toJson() => {
        "amenities": List<dynamic>.from(amenities!.map((x) => x)),
        "business_uid": businessUid,
        "images": List<dynamic>.from(images!.map((x) => x)),
        // "operating_hours": operatingHours!.toJson(),
        "operating_hours": operatingHours != null ? operatingHours!.toJson() : null,
    };
}



class OperatingHours {

  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;

  OperatingHours({

    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(

    monday: Day.fromJson(json["Monday"]),
    tuesday: Day.fromJson(json["Tuesday"]),
    wednesday: Day.fromJson(json["Wednesday"]),
    thursday: Day.fromJson(json["Thursday"]),
    friday: Day.fromJson(json["Friday"]),
    saturday: Day.fromJson(json["Saturday"]),
    sunday: Day.fromJson(json["Sunday"]),
  );

  Map<String, dynamic> toJson() => {
    "Monday": monday.toJson(),
    "Tuesday": tuesday.toJson(),
    "Wednesday": wednesday.toJson(),
    "Thursday": thursday.toJson(),
    "Friday": friday.toJson(),
    "Saturday": saturday.toJson(),
    "Sunday": sunday.toJson(),
  };

  // Method to convert OperatingHours to Map<String, Map<String, dynamic>>
  Map<String, Map<String, dynamic>> toMap() {
    return {

      "Monday": monday.toMap(),
      "Tuesday": tuesday.toMap(),
      "Wednesday": wednesday.toMap(),
      "Thursday": thursday.toMap(),
      "Friday": friday.toMap(),
      "Saturday": saturday.toMap(),
      "Sunday": sunday.toMap(),
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

