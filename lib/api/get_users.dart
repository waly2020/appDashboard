import 'dart:convert';
// import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/user_conected.dart';
import '../pages/details/details_user.dart';

Future<List> fetchAllUsers() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.179:8001/api/users/get/${0}'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("N'as pas pue recupere les utilisateurs");
  }
}


FutureBuilder listAllUser(Future futureUser) {
  return FutureBuilder(
    future: futureUser,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<dynamic> data = snapshot.data;
        return Column(
          children: data.reversed.map(
                (user) => UserConected(
                  nom: user["nom"],
                  prenom: user["prenom"],
                  email: user['email'],
                  acces: user['acces'],
                  actions: user['actions'],
                  isActive: user['isActive'],
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (a, b, c) => DetailsUser(user: user)
                        )
                    );
                  },
                ),
              ).toList(),
        );
      } else if (snapshot.hasError) {
        debugPrint("${snapshot.error}");
      }

      // By default, show a loading spinner.
      return const CircularProgressIndicator();
    },
  );
}
