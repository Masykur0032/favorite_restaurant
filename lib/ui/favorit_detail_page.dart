import 'package:fav_resto/data/api/api_service_favorit_detail.dart';
import 'package:fav_resto/data/model/favorite.dart';
import 'package:fav_resto/data/model/favorite_detail.dart';
import 'package:fav_resto/provider/favorite_detail_provider.dart';
import 'package:fav_resto/ui/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPageFavorite extends StatelessWidget {
  static const routeName = '/favorite_resto_detail';

  final Favorite favorite;

  const RestaurantDetailPageFavorite({required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetailProviderFavorit>(
        create: (_) => DetailProviderFavorit(
            apiServiceDetailFavorite:
                ApiServiceDetailFavorite(idDetail: favorite.idFavorite!)),
        //child: FavoriteDetailPage(),
      ),
    );
  }
}
