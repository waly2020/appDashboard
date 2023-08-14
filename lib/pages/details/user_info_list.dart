import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInfoList extends StatelessWidget {
  String label;
  String value;
  UserInfoList({super.key,this.label = "lebel",this.value = "value"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFFFFFFFF)),
          ),
          Text(
            value,
            style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
