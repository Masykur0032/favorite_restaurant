import 'dart:convert';
import 'package:fav_resto/data/model/restaurant_search_detail.dart';
import 'package:http/http.dart' as http;

class ApiServiceDetailSearch {
  static final String _apiKeyDetail =
      'https://restaurant-api.dicoding.dev/detail/';
  String idDetail;

  ApiServiceDetailSearch({required this.idDetail});

  Future<DetailSearch> topDetaillines() async {
    final response = await http.get(Uri.parse(_apiKeyDetail + idDetail));
    if (response.statusCode == 200) {
      return DetailSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
