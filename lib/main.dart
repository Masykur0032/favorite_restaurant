import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:fav_resto/common/styles.dart';
import 'package:fav_resto/data/model/favorite.dart';
//import 'package:fav_resto/data/model/favorite_detail.dart';
import 'package:fav_resto/data/model/restaurant.dart';
import 'package:fav_resto/data/model/restaurant_search.dart';
import 'package:fav_resto/notification/background_service.dart';
import 'package:fav_resto/notification/navigation.dart';
import 'package:fav_resto/notification/notification_helper.dart';
import 'package:fav_resto/ui/favorit_detail_page.dart';
import 'package:fav_resto/ui/favorite_page.dart';
import 'package:fav_resto/ui/home_page.dart';
import 'package:fav_resto/ui/resto_detail_page.dart';
import 'package:fav_resto/ui/resto_search_page.dart';
import 'package:fav_resto/ui/search_resto_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// void main() async {
//   runApp(MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resto App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(bodyColor: Colors.black),
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            textStyle: TextStyle(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
      ),
      initialRoute: HomePage.routeName,
      navigatorKey: navigatorKey,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
        RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(
              nameRestaurant:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        RestaurantDetailPageSearch.routeName: (context) =>
            RestaurantDetailPageSearch(
              restaurant: ModalRoute.of(context)?.settings.arguments
                  as RestaurantSearch,
            ),
        RestaurantDetailPageFavorite.routeName: (context) =>
            RestaurantDetailPageFavorite(
              favorite: ModalRoute.of(context)?.settings.arguments as Favorite,
            ),
        FavoriteDetailPage.routeName: (context) => FavoriteDetailPage(
              favorite: ModalRoute.of(context)?.settings.arguments as Favorite,
            ),
      },
    );
  }
}
