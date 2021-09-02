import 'package:fav_resto/data/model/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteDetailPage extends StatelessWidget {
  static const routeName = '/favorite_detail';

  final Favorite favorite;

  const FavoriteDetailPage({required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Resto App'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: favorite.urlImage!,
                child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/' +
                        favorite.urlImage!),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            favorite.name!,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "img/location.png",
                                  width: 10,
                                ),
                                Text(
                                  favorite.city!,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "img/rating.png",
                                  width: 10,
                                ),
                                Text(
                                  favorite.rating!,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.green),
                    Text(
                      favorite.desc!,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.justify,
                    ),
                    Divider(color: Colors.green),
                    Text(
                      'Food list',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      favorite.foods!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Divider(color: Colors.green),
                    Text(
                      'Drink list',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      favorite.drinks!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
