import 'package:fav_resto/data/helper/database_helper.dart';
import 'package:fav_resto/data/model/favorite.dart';
import 'package:flutter/foundation.dart';

class DbProvider extends ChangeNotifier {
  List<Favorite> _favorite = [];
  late DbHelper _dbHelper;

  List<Favorite> get favorite => _favorite;

  DbProvider() {
    _dbHelper = DbHelper();
    _getAllFavorite();
  }

  void _getAllFavorite() async {
    _favorite = await _dbHelper.getFavoriteList();
    notifyListeners();
  }

  Future<void> addFavorite(Favorite favorite) async {
    await _dbHelper.insert(favorite);
    _getAllFavorite();
  }

  // Future<Favorite> getFavoriteById(int id) async {
  //   return await _dbHelper.getFavoriteById(id);
  // }

  void updateFavorite(Favorite favorite) async {
    await _dbHelper.update(favorite);
    _getAllFavorite();
  }

  void deleteFavorite(int id) async {
    await _dbHelper.delete(id);
    _getAllFavorite();
  }
}
