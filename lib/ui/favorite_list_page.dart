import 'package:fav_resto/data/helper/database_helper.dart';
import 'package:fav_resto/data/model/favorite.dart';
import 'package:fav_resto/ui/favorite_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePage extends StatefulWidget {
  static const String favoriteTitle = 'Favorite List';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  late List<Favorite> itemList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => updateListView());
    return Scaffold(
      appBar: AppBar(
        title: Text(FavoritePage.favoriteTitle),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final favorite = itemList[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Hero(
              tag: favorite.urlImage!,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/' +
                    favorite.urlImage!,
                width: 100,
              ),
            ),
            title: Text(
              favorite.name!,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        int result = await dbHelper.delete(favorite.id!);
                        if (result > 0) {
                          updateListView();
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () => Navigator.pushNamed(
              context,
              FavoriteDetailPage.routeName,
              arguments: favorite,
            ),
          );
        },
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Favorite>> itemListFuture = dbHelper.getFavoriteList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
