import 'dart:io';
import 'package:fav_resto/notification/custom_dialog.dart';
import 'package:fav_resto/notification/scheduling_provider.dart';
import 'package:fav_resto/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String settingsTitle = 'Settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsPage.settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(SettingsPage.settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(children: [
      Material(
        child: ListTile(
          title: Text('Scheduling News'),
          trailing: Consumer<SchedulingProvider>(
            builder: (context, scheduled, _) {
              return Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    scheduled.scheduledNews(value);
                  }
                },
              );
            },
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
