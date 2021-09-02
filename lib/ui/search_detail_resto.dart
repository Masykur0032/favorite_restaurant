import 'package:fav_resto/data/helper/database_helper.dart';
import 'package:fav_resto/data/model/favorite.dart';
import 'package:fav_resto/provider/search_detail_provider.dart';
import 'package:fav_resto/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class DetailPageSearch extends StatefulWidget {
  //late final Favorite? favorite;

  @override
  _DetailPageSearchState createState() => _DetailPageSearchState();
}

class _DetailPageSearchState extends State<DetailPageSearch> {
  // late final Favorite favorite;
  // TextEditingController _idFavoriteController = TextEditingController();
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _urlImageController = TextEditingController();
  // TextEditingController _cityController = TextEditingController();
  // TextEditingController _ratingController = TextEditingController();

  // DatabaseHelper dbHelper = DatabaseHelper();

  // bool _isUpdate = false;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.favorite != null) {
  //     _idFavoriteController.text = widget.favorite!.idFavorite;
  //     _nameController.text = widget.favorite!.name;
  //     _urlImageController.text = widget.favorite!.urlImage;
  //     _cityController.text = widget.favorite!.city;
  //     _ratingController.text = widget.favorite!.rating.toString();
  //     _isUpdate = true;
  //   }
  // }

  DbHelper dbHelper = DbHelper();
  int count = 0;
  late List<Favorite> itemList;
  late final Favorite item;

  Widget _buildList() {
    return Consumer<DetailProviderSearch>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurantDetail = state.result.restaurant;
          return SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: restaurantDetail.pictureId,
                  child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/' +
                          restaurantDetail.pictureId),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurantDetail.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              RaisedButton(
                                  onPressed: () async {
                                    String foodie = '- ' +
                                        restaurantDetail.menus.foods[0].name +
                                        '\n- ' +
                                        restaurantDetail.menus.foods[1].name +
                                        '\n- ' +
                                        restaurantDetail.menus.foods[2].name +
                                        '\n- ' +
                                        restaurantDetail.menus.foods[3].name +
                                        ', dll...';

                                    String drinkie = '- ' +
                                        restaurantDetail.menus.drinks[0].name +
                                        '\n- ' +
                                        restaurantDetail.menus.drinks[1].name +
                                        '\n- ' +
                                        restaurantDetail.menus.drinks[2].name +
                                        '\n- ' +
                                        restaurantDetail.menus.drinks[3].name +
                                        ', dll...';

                                    item = Favorite(
                                      idFavorite: restaurantDetail.id,
                                      name: restaurantDetail.name,
                                      desc: restaurantDetail.description,
                                      urlImage: restaurantDetail.pictureId,
                                      city: restaurantDetail.city,
                                      rating:
                                          restaurantDetail.rating.toString(),
                                      foods: foodie,
                                      drinks: drinkie,
                                    );
                                    int result = await dbHelper.insert(item);
                                    if (result > 0) {
                                      updateListView();
                                    }
                                  },
                                  color: Color.fromRGBO(16, 255, 12, 1.0),
                                  child: Text(
                                    'Add Favorite',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                            ],
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
                                    restaurantDetail.city,
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
                                    restaurantDetail.rating.toString(),
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
                        restaurantDetail.description,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.justify,
                      ),
                      Divider(color: Colors.green),
                      Text(
                        'Food list',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: restaurantDetail.menus.foods.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Image.asset(
                                  "img/foods.png",
                                  width: 8,
                                ),
                                Text(
                                  ' ' +
                                      restaurantDetail.menus.foods[index].name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            );
                          }),
                      Divider(color: Colors.green),
                      Text(
                        'Drink list',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: restaurantDetail.menus.drinks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Image.asset(
                                  "img/drinks.png",
                                  width: 8,
                                ),
                                Text(
                                  ' ' +
                                      restaurantDetail.menus.drinks[index].name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            );
                          }),
                      Divider(color: Colors.green),
                      Text(
                        'Customer Review',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: restaurantDetail.customerReviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ' +
                                      restaurantDetail
                                          .customerReviews[index].name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Date: ' +
                                      restaurantDetail
                                          .customerReviews[index].date,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Review: ' +
                                      restaurantDetail
                                          .customerReviews[index].review,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const Divider(
                                    thickness: 0.1,
                                    indent: 20,
                                    endIndent: 50,
                                    color: Colors.green),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resto App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Resto App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
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
