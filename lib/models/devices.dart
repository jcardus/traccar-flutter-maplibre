import 'package:flutter/material.dart';
import 'package:traccar_flutter_maplibre/api.dart';
import 'package:traccar_flutter_maplibre/models/user.dart';

class DevicesModel extends ChangeNotifier {
  late UserModel _user;
  static List<dynamic> _devices = [];

  UserModel get user => _user;
  List<dynamic> get items => _devices;

  set user(UserModel user) {
    _user = user;
    fetch(user.server, user.cookie, 'devices').then((devices) => _devices=devices);
    notifyListeners();
  }

  Device getById(int id) => Device(id, _devices[id]['name']);
}

@immutable
class Device {
  final int id;
  final String name;
  final Color color = Colors.red;

  Device(this.id, this.name);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Device && other.id == id;
}
