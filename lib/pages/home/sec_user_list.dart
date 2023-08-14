import 'package:dashboard/api/get_users.dart';
import 'package:dashboard/components/user_conected.dart';
import 'package:dashboard/pages/details/details_user.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
// SecUserList
class SecUserList extends StatefulWidget {
  const SecUserList({super.key});

  @override
  State<SecUserList> createState() => _SecUserListState();
}

class _SecUserListState extends State<SecUserList> {
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
      // height: 400,
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      padding: const EdgeInsets.all(10),
      decoration: containerDecoration(),
      child: StreamBuilder(
              stream: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  datas = snapshot.data;
                  return Column(
                    children: datas.reversed.map(
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
                                      pageBuilder: (a, b, c) =>
                                          DetailsUser(user: user)));
                            },
                          ),
                        ).toList(),
                  );
                } else if (snapshot.hasError) {
                  return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: Icon(Icons.signal_wifi_connected_no_internet_4_sharp,color: mainColor,size: 70,),
                );
                }

                // By default, show a loading spinner.
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: const CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}