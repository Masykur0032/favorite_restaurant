import 'package:fav_resto/data/api/api_service_search_detail.dart';
import 'package:fav_resto/data/model/restaurant_search.dart';
import 'package:fav_resto/provider/search_detail_provider.dart';
import 'package:fav_resto/ui/search_detail_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPageSearch extends StatelessWidget {
  static const routeName = '/search_resto_detail';

  final RestaurantSearch restaurant;

  const RestaurantDetailPageSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetailProviderSearch>(
        create: (_) => DetailProviderSearch(
            apiServiceDetailSearch:
                ApiServiceDetailSearch(idDetail: restaurant.id)),
        child: DetailPageSearch(),
      ),
    );
  }
}
