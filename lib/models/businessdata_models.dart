// To parse this JSON data, do
//
//     final businessDataModels = businessDataModelsFromJson(jsonString);

import 'dart:convert';

List<BusinessDataModels> businessDataModelsFromJson(String str) => List<BusinessDataModels>.from(json.decode(str).map((x) => BusinessDataModels.fromJson(x)));

String businessDataModelsToJson(List<BusinessDataModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessDataModels {
    String? address;
    String businessDescription;
    dynamic businessEmail;
    String businessName;
    String businessUid;
    String category;
    String contactInformation;
    String country;
    double latitude;
    double longitude;
    String? profileImageUrl;
    String subCategory;
    String userid;
    bool isPremium;
    dynamic premiumExpiry;

    BusinessDataModels({
        required this.address,
        required this.businessDescription,
        required this.businessEmail,
        required this.businessName,
        required this.businessUid,
        required this.category,
        required this.contactInformation,
        required this.country,
        required this.latitude,
        required this.longitude,
        required this.profileImageUrl,
        required this.subCategory,
        required this.userid,
        required this.isPremium,
        required this.premiumExpiry,
    });

    factory BusinessDataModels.fromJson(Map<String, dynamic> json) => BusinessDataModels(
        address: json["address"],
        businessDescription: json["business_description"],
        businessEmail: json["business_email"],
        businessName: json["business_name"],
        businessUid: json["business_uid"],
        category: json["category"],
        contactInformation: json["contact_information"],
        country: json["country"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        profileImageUrl: json["profile_image_url"],
        subCategory: json["sub_category"],
        userid: json["userid"],
        premiumExpiry: json["premium_expiry"],
        isPremium: json["is_premium"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "business_description": businessDescription,
        "business_email": businessEmail,
        "business_name": businessName,
        "business_uid": businessUid,
        "category": category,
        "contact_information": contactInformation,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "profile_image_url": profileImageUrl,
        "sub_category": subCategory,
        "userid": userid,
        "is_premium": isPremium,
        "premium_expiry": premiumExpiry,
    };
}
