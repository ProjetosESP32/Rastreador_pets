import 'package:pet_tracker_ifmt/data/Channel.dart';
import 'package:flutter/material.dart';
import 'package:pet_tracker_ifmt/data/Message.dart';

String usernameFileName = "user.name";

String localUser;

ValueNotifier<List<ValueNotifier<Channel>>> channels =
    new ValueNotifier<List<ValueNotifier<Channel>>>(<ValueNotifier<Channel>>[]);

UserLocation currentLocation = UserLocation(longitude: 0, latitude: 0);
