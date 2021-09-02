import 'dart:async';
import 'package:fav_resto/data/api/api_service_search_detail.dart';
import 'package:fav_resto/data/model/restaurant_search_detail.dart';
import 'package:flutter/material.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProviderSearch extends ChangeNotifier {
  final ApiServiceDetailSearch apiServiceDetailSearch;

  DetailProviderSearch({required this.apiServiceDetailSearch}) {
    _fetchDetailRestaurant();
  }

  late DetailSearch _detailSearch;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailSearch get result => _detailSearch;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiServiceDetailSearch.topDetaillines();
      _state = ResultState.HasData;
      notifyListeners();
      return _detailSearch = restaurant;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'TERJADI KESALAHAN, SILAHKAN PERIKSA KONEKSI INTERNET ANDA';
    }
  }
}
