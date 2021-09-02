import 'package:fav_resto/provider/list_provider.dart';
import 'package:fav_resto/ui/resto_search_page.dart';
import 'package:fav_resto/widgets/card_resto.dart';
import 'package:fav_resto/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildList() {
    TextEditingController searchController = new TextEditingController();
    String nameResto = 'namaRestaurant';
    return Consumer<ListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: 1,
                        ),
                      ),
                      Expanded(
                        flex: 75,
                        child: TextField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Cari Nama Restaurant...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 15,
                          child: IconButton(
                              onPressed: () {
                                nameResto = searchController.text;
                                Navigator.pushNamed(
                                  context,
                                  RestaurantSearchPage.routeName,
                                  arguments: nameResto,
                                );
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Color.fromRGBO(16, 255, 12, 1.0),
                              ))),
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          width: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return CardRestaurant(restaurant: restaurant);
                      },
                    ),
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
}
