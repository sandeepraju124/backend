import "dart:convert";

import "package:backendapp/utils/constants.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class InsightsProvider extends ChangeNotifier {
  Map<String, dynamic>? _reviewData;
  bool _isLoading = false;

  Map<String, dynamic>? get reviewData => _reviewData;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _profileVisitData;
  bool _isLoadingProfile = false;

  Map<String, dynamic>? get profileVisitData => _profileVisitData;
  bool get isLoadingProfile => _isLoadingProfile;

  Future<void> fetchReviewData(String businessUid) async {
    try {
      _isLoading = true;
      notifyListeners();

      var url = "$baseUrl/overall_rating/$businessUid/6";
      // var url = "https://supernova1137.azurewebsites.net/overall_rating/PIZFOO4357128905678/6";
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        _reviewData = json.decode(response.body);
        // _isLoading = false;
      } else {
        throw Exception('Failed to load review data');
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchprofileVisitData(String businessUid) async {
    try {
      _isLoadingProfile = true;
      notifyListeners();

      // var url = "https://supernova1137.azurewebsites.net/provile_visit?business_id=200newagain";
      var url = "$baseUrl/provile_visit?business_id=$businessUid";
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        _profileVisitData = json.decode(response.body);
        // _isLoading = false;
      } else {
        throw Exception('Failed to load review data');
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      _isLoadingProfile = false;
      notifyListeners();
    }
  }
}
