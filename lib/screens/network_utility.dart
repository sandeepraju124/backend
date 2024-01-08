
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {

  Future<String?> fetchUrl(Uri url,{Map<String,String>? headers}) async {
    try {
      final response = await http.get(url, headers: headers);
      // print(response.body);
      if (response.statusCode == 200){
        print("response body");
        print(response.body);
        return response.body;
      }

    } catch (e) {
      debugPrint(e.toString());
      
    }
    return null;

  }
}