import 'dart:convert';

import 'package:click_send/model/locationsuggestion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;

class SearchProvider extends ChangeNotifier {
  LocationSuggestion? _locationSuggestion;
  TextEditingController currentLocationController = TextEditingController();

  LocationSuggestion? get locationSuggestion => _locationSuggestion;
  Future<LocationSuggestion> fetchSuggestions(String query) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&key=AIzaSyC07yiu61F_nw9V3T1duKE70HrZBgQNY3M&region=IN';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        _locationSuggestion = LocationSuggestion.fromJson(result);
        notifyListeners();

        return LocationSuggestion.fromJson(result);
      }
      if (result['status'] == 'ZERO_RESULTS') {
        //      throw NotFoundException();
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
    notifyListeners();

    throw UnimplementedError();
  }
}
