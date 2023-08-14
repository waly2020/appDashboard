// import 'package:dashboard/pages/content_pages/content_pages.dart';
import 'package:dashboard/pages/login/login.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // mise en place de HIVE pour stocke les donnnees
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: ContentPages(),
    );
  }
}
