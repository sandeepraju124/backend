// To parse this JSON data, do
//
//     final houseModels = houseModelsFromJson(jsonString);

import 'dart:convert';

List<HouseModels> houseModelsFromJson(String str) => List<HouseModels>.from(json.decode(str).map((x) => HouseModels.fromJson(x)));

String houseModelsToJson(List<HouseModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class HouseModels {
  String? advance;
  int? bedrooms;
  int? buildingAge;
  String? businessUid;
  bool? carParking;
  String? furnishingLevel;
  String? houseFacing;
  String? houseType;
  String? location;
  String? preferred;
  String? price;

  HouseModels({
    this.advance,
    this.bedrooms,
    this.buildingAge,
    this.businessUid,
    this.carParking,
    this.furnishingLevel,
    this.houseFacing,
    this.houseType,
    this.location,
    this.preferred,
    this.price,
  });

  factory HouseModels.fromJson(Map<String, dynamic> json) => HouseModels(
    advance: json["advance"],
    bedrooms: json["bedrooms"],
    buildingAge: json["building_age"],
    businessUid: json["business_uid"],
    carParking: json["car_parking"],
    furnishingLevel: json["furnishing_level"],
    houseFacing: json["house_facing"],
    houseType: json["house_type"],
    location: json["location"],
    preferred: json["preferred"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "advance": advance,
    "bedrooms": bedrooms,
    "building_age": buildingAge,
    "business_uid": businessUid,
    "car_parking": carParking,
    "furnishing_level": furnishingLevel,
    "house_facing": houseFacing,
    "house_type": houseType,
    "location": location,
    "preferred": preferred,
    "price": price,
  };
}
