import 'dart:convert';
import 'package:fav_resto/data/model/restaurant_search.dart';
import 'package:http/http.dart' as http;

class ApiServiceSearch {
  static final String _apiKeySearch =
      'https://restaurant-api.dicoding.dev/search?q=';
  String query;

  ApiServiceSearch({required this.query});

  Future<Search> topSearchlines() async {
    final response = await http.get(Uri.parse(_apiKeySearch + query));
    if (response.statusCode == 200) {
      return Search.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
