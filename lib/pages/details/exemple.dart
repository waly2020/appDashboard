import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExempleWidget extends StatefulWidget {
  int age;
  ExempleWidget({super.key,required this.age});

  @override
  State<ExempleWidget> createState() => _ExempleWidgetState();
}

class _ExempleWidgetState extends State<ExempleWidget> {
  String nom = "hello";
  
  @override
  Widget build(BuildContext context) {
    return const Text("Mon nom est");
  }
}