import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../api.dart';

class UserModel extends ChangeNotifier {
  late Map<String, dynamic> session;
  late List<dynamic> devices;
  late String cookie;
  String server = 'demo4.traccar.org';
  late WebSocketChannel _channel;


  Future<int> login(String username, String password) async {
    var url = Uri.https(server, '/api/session');
    var body = <String, String>{};
    body['email'] = username;
    body['password'] = password;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      session = jsonDecode(response.body);
      var headers = response.headers['set-cookie']!.split(";");
      cookie = headers.firstWhere((h) => h.split('=')[0] == 'JSESSIONID');
      devices = await fetch(server, cookie, 'devices');
      // openSocket();
    }
    return response.statusCode;
  }

  openSocket() {
    _channel = IOWebSocketChannel.connect(
        Uri.parse('wss://$server/api/socket'),
        headers: {'Cookie': cookie}
    );
    _channel.stream.listen((message) {
      var _message = jsonDecode(message);
      if (_message.containsKey('devices')) {
        print(message);
      }
    });
  }
}
