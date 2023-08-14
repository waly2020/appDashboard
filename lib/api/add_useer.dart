import 'dart:convert';
import 'package:http/http.dart' as http;

addUser(Map<String,dynamic> body) async {
  final response = await http.post(
    Uri.parse("http://192.168.1.179:8001/api/auth/create"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if(response.statusCode == 201){
    return jsonDecode(response.body);
  }else{
    throw Exception("Utilisateur non cree");
  }
}