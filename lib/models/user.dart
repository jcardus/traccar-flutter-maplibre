import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserModel extends ChangeNotifier {
  late Map<String, dynamic> session;
  late String cookie;
  String server = 'demo4.traccar.org';

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
    }
    return response.statusCode;
  }
}
