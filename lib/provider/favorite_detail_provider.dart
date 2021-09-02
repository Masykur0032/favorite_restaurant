import 'dart:async';
import 'package:fav_resto/data/api/api_service_favorit_detail.dart';
import 'package:fav_resto/data/model/favorite_detail.dart';
import 'package:flutter/material.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProviderFavorit extends ChangeNotifier {
  final ApiServiceDetailFavorite apiServiceDetailFavorite;

  DetailProviderFavorit({required this.apiServiceDetailFavorite}) {
    _fetchDetailRestaurant();
  }

  late FavoriteDetail _favoriteDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  FavoriteDetail get result => _favoriteDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiServiceDetailFavorite.topDetaillines();
      _state = ResultState.HasData;
      notifyListeners();
      return _favoriteDetail = restaurant;
      /*
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detail = restaurant;
      }
      */
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'TERJADI KESALAHAN, SILAHKAN PERIKSA KONEKSI INTERNET ANDA \n\nDetail: \nError --> $e';
    }
  }
}
