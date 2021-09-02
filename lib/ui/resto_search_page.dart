import 'package:fav_resto/data/api/api_service_search.dart';
import 'package:fav_resto/provider/search_provider.dart';
import 'package:fav_resto/ui/search_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/resto_search';

  final String nameRestaurant;

  const RestaurantSearchPage({required this.nameRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(
            apiServiceSearch: ApiServiceSearch(query: nameRestaurant)),
        child: RestaurantListPageSearch(),
      ),
    );
  }
}
