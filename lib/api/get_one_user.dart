import 'dart:convert';

import 'package:http/http.dart' as http;

String url = "http://192.168.1.179:8001/api/users/get/user";


Future getOneUser(dynamic id) async {
  final response = await http.get(Uri.parse('$url/$id'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("N'as pas pue recupere l'utilisateurs");
  }
}