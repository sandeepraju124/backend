import "dart:convert";

import "package:backendapp/provider/registrationdata.dart";
import "package:http/http.dart"as http;
import "package:provider/provider.dart";

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