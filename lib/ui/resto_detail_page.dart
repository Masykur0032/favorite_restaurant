import 'package:fav_resto/data/api/api_service_detail.dart';
import 'package:fav_resto/data/model/restaurant.dart';
import 'package:fav_resto/provider/detail_provider.dart';
import 'package:fav_resto/ui/detail_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(
            apiServiceDetail: ApiServiceDetail(idDetail: restaurant.id)),
        child: DetailPage(),
      ),
    );
  }
}
