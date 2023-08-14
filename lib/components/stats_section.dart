import 'package:dashboard/api/get_users.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

//StatsSection
class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  List<dynamic> datas = [];
  late Stream futureUser;
  @override
  void initState() {
    super.initState();
    futureUser = Stream.periodic(const Duration(seconds: 2)).asyncMap((event) async => await fetchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(30),
      decoration: containerDecoration(),
      child: StreamBuilder(
        stream: futureUser,
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
          datas = snapshot.data;
          int admin = datas.where((e) => e['acces'] == "Admin").length;
          int actif = datas.where((e) => e['isActive'] == 1).length;
          int notActif = datas.where((e) => e['isActive'] == 0).length;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statItems(label: "admins",value: "$admin"),
                statItems(
                    value: "$actif",
                    label: "activé",
                    icon: Icons.fiber_manual_record_sharp,
                    color: const Color(0xFF64D168)),
                statItems(
                    value: "$notActif",
                    label: "agents",
                    icon: Icons.settings_rounded,
                    color: const Color(0xFFB950A4)),
              ],
            );
          }
          // By default, show a loading spinner.
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget statItems(
    {String label = "Admin",
    String value = "12",
    IconData icon = Icons.manage_accounts,
    Color color = const Color(0xFF3291DF)}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: color,
        size: 25,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    ],
  );
}
