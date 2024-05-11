import "dart:convert";

import "package:backendapp/models/askcommunitymodel.dart";
import "package:backendapp/models/businessdata_models.dart";
import 'package:backendapp/models/services_model.dart';
import "package:backendapp/models/commentsection_models.dart";
import 'package:backendapp/provider/registrationdata_provider.dart';
import "package:http/http.dart"as http;
import "package:provider/provider.dart";
import 'dart:developer';

class NetworkCalling{


//   Future<String?> postBusinessData(uri, body)async{
//   final headers = {'Content-Type': 'application/json'};
//     final response = await http.post(uri, headers: headers, body: body);
//     if (response.statusCode == 200) {
//       return 'Service created successfully';
//     } else {
//       throw Exception('Failed to create service');
//     }
// }

Future<String> getLocationName(double latitude, double longitude, String apiKey) async{
  final String baseurl = "https://maps.googleapis.com/maps/api/geocode/json";
  final String endpoint = "$baseurl?latlng=$latitude,$longitude&key=$apiKey";

  final response = await http.get(Uri.parse(endpoint));

  if(response.statusCode == 200){
    final Map<String, dynamic> data = json.decode(response.body);
    // print(response.body);
    print("body");
    // print(data["results"][0]["formatted_address"]);
    // print(data["results"][0]["address_components"][0]["short_name"]);

    if (data.containsKey("results") && (data["results"] as List).isNotEmpty ){
      List<dynamic> addressComponents = data["results"][0]["address_components"];
      String shortName = addressComponents.isNotEmpty ? addressComponents[0]["short_name"] : "N/A";
      // String formatted_address = data["results"][0]["formatted_address"]
      print(shortName);
      print(data["results"][0]["formatted_address"]);
      // return shortName;
      return data["results"][0]["formatted_address"];
    } else {
      throw Exception("location not found");
    }

  }else {
    throw Exception("Failed to load data");
  }

}

Future<AskTheCommunityModels> fetchAskCommunity(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      // print('Decoded JSON: $decodedJson'); // Debug print
      var askCommunity = AskTheCommunityModels.fromJson(decodedJson);
      return askCommunity;
    } else {
      throw Exception('Failed to load business profile');
    }
  }



  Future<CommentSectionModels> fetchComments(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var comments = CommentSectionModels.fromJson(json.decode(response.body));
      return comments;
    } else {
      throw Exception('Failed to load business profile');
    }
  }

  // this is for getting business data from pg admin database business table
Future<List<BusinessDataModels>> fetchBusinessData(String uri) async {
  var url = Uri.parse(uri);
  var response = await http.get(url);
  print(response.body);
  print("data from http");
  if (response.statusCode == 200) {
    // Parse the response JSON into a list of BusinessDataModels
    List<dynamic> data = json.decode(response.body);
    print("businessDataList");
    List<BusinessDataModels> businessDataList = data
        .map((json) => BusinessDataModels.fromJson(json))
        .toList();
        // print(businessDataList);
        // print("businessDataList");
    return businessDataList;
  } else {
    throw Exception('Failed to fetch business data');
  }
}

// updating business data
Future<http.Response> patchBusinessData(String uri, dynamic data) async {
    var url = Uri.parse(uri);
    final headers = {'Content-Type': 'application/json'};
    var response = await http.patch(
      url,
      body: jsonEncode(data),
      headers:headers
    );
    // print(response.body);
    // print("response");
    return response;
  }


// this is for getting business oprational data from mongodb database
// services data
// Future<ServicesModels> fetchMongoBusinessData(String uri)async{
//   var url = Uri.parse(uri);
//   var response = await http.get(url);
//   // print(response.body);
//   // print(response.body.toString());
//   log(response.body);
//   print("http business service data");
//   print(response.statusCode);
//   if (response.statusCode == 200){
//     print("in to the if");
//     ServicesModels data = ServicesModels.fromJson(json.decode(response.body));
//     print(data);
//     // print("http business mongo data");
//     return data;
    
//   }else{
//     throw Exception("Failed to load mongo business data");
//   }
// }

Future<ServicesModels> fetchMongoBusinessData(String uri) async {
  try {
    var url = Uri.parse(uri);
    var response = await http.get(url);
    log(response.body);

    if (response.statusCode == 200) {
      return ServicesModels.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load mongo business data");
    }
  } catch (e) {
    // Handle any exceptions that occur during the HTTP request
    print("Error fetching mongo business data: $e");
    throw Exception("Failed to load mongo business data");
  }
}



// Future<String?> postBusiness() async {
//   // var data = Provider.of<RegistrationProvider>;
//     print("before try");
//     try {
//       print("inside try");
//       final url = Uri.parse("https://supernova1137.azurewebsites.net/testingdataimageupdate");
//       // final url = Uri.parse('https://revolution.azurewebsites.net/services');
//       // final headers = {'Content-Type': 'application/json'};

//       Map<String, String> body = {
//         'business_name': _businessName.text,
//         'business_description': _businessEmail.text,
//         'contact_information': _contactInfo.text,
//         'country': "india",
//         'catagory': category.toString(),
//         'sub_catagory': sub_category.toString(),
//         // 'latitude':widget.lat.toString(),
//         // 'langitude' : widget.lang.toString()
//         // 'image' : _ffsaiImage
//       };
//       print(" try");

//       // final response = await http.post(url, body: body);
//       final request = http.MultipartRequest('POST', url)
//         ..files.add(await http.MultipartFile.fromPath(
//             'profile_image', _profileimage!.path))
//         ..fields.addAll(body);
//       final response = await request.send();
//       print(response.statusCode);
//       print(response);
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         print(responseBody);
//         return 'Service created successfully';
//       } else {
//         throw Exception('Failed to create service');
//       }
//     } catch (e) {
//       print(e.toString());
//       throw Exception('Failed to create service: $e');
//     }
//   }

}