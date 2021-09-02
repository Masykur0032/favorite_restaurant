import 'package:fav_resto/data/model/restaurant_search.dart';
import 'package:fav_resto/ui/search_resto_detail_page.dart';
import 'package:flutter/material.dart';

class CardSearchRestaurant extends StatelessWidget {
  final RestaurantSearch restaurant;

  const CardSearchRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/' +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "img/location.png",
                  width: 10,
                ),
                Text(
                  restaurant.city,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "img/rating.png",
                  width: 10,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPageSearch.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
