import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_tracker_ifmt/screens/Home.dart';
import 'package:pet_tracker_ifmt/connectors/Database.dart';
import 'package:pet_tracker_ifmt/connectors/Location.dart';
import 'package:pet_tracker_ifmt/connectors/Username.dart';
import 'package:pet_tracker_ifmt/data/Channel.dart';
import 'package:pet_tracker_ifmt/data/Message.dart';
import 'package:pet_tracker_ifmt/data/Globals.dart';
import 'package:pet_tracker_ifmt/screens/BluetoothSettings.dart';
import 'package:pet_tracker_ifmt/screens/UserSettings.dart';

void main() {
  runApp(new AppMainClass());
}

class AppMainClass extends StatelessWidget {
  final DBConnector dbHelper = DBConnector.instance;

  @override
  Widget build(BuildContext context) {
    UserLocationStream().initLocation();

    BluetoothOffScreenState.reconnect();

    UsernameConnector.read();

    dbHelper.queryAllRows().then((rows) {
      for (Map<String, dynamic> row in rows) {
        String channelName = row[DBConnector.columnName];
        bool attending =
            row[DBConnector.columnAttending].toLowerCase() == "true";
        String messagesJson = row[DBConnector.columnMessages];
        Iterable jsonObjects = json.decode(messagesJson);
        List<Message> messages =
            jsonObjects.map((item) => Message.fromJson(item)).toList();
        ValueNotifier<Channel> _chn =
            ValueNotifier<Channel>(Channel(channelName, attending, messages));
        if (Channel.getChannel(_chn.value.name) != null) {
          continue;
        }
        channels.value.add(_chn);
        //channels.notifyListeners();
      }
    });
    return new MaterialApp(
      title: "BlueRa",
      home: localUser == null ? UserSettingsScreen() : HomeScreen(),
    );
  }
}
