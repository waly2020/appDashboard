import 'package:dashboard/components/stats_section.dart';
import 'package:dashboard/pages/home/header_home.dart';
import 'package:dashboard/pages/home/sec_user_list.dart';
import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  const ContentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeaderHome(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: StatsSection(),
          ),
          SecUserList(),
        ],
      ),
    );
  }
}
/**
 * 
 */ 