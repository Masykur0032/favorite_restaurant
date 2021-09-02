import 'dart:convert';
import 'package:fav_resto/data/model/favorite_detail.dart';
import 'package:http/http.dart' as http;

class ApiServiceDetailFavorite {
  static final String _apiKeyDetail =
      'https://restaurant-api.dicoding.dev/detail/';
  String idDetail;

  ApiServiceDetailFavorite({required this.idDetail});

  Future<FavoriteDetail> topDetaillines() async {
    final response = await http.get(Uri.parse(_apiKeyDetail + idDetail));
    if (response.statusCode == 200) {
      return FavoriteDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
