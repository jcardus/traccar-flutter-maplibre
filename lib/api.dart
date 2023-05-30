import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetch(server, cookie, entity) async {
  final response = await http.get(Uri.https(server, 'api/$entity'), headers: {'Cookie': cookie});
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load $entity');
  }
}
