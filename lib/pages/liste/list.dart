import 'package:dashboard/api/get_users.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../components/user_conected.dart';
import '../details/details_user.dart';

class ListePage extends StatefulWidget {
  const ListePage({super.key});

  @override
  State<ListePage> createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> {
  bool _allAdmin = false;
  bool _allAgent = false;
  bool _allActif = false;
  bool _allWait = false;

  bool _all = true;
  String column = "nom";
  dynamic colValue = "";
  String searchText = "";
  late Stream futureUser;
  List<dynamic> data = [];
  List<dynamic> filterData = [];
  @override
  void initState() {
    super.initState();
    futureUser = Stream.periodic(const Duration(seconds: 2)).asyncMap((event) async => await fetchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // header pour la rechrche
          Container(
            // height: 160 + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 30, bottom: 10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: containerDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              filled: true,
                              hintText: "Recherche...",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(107, 255, 255, 255)
                              ),
                              fillColor: Color.fromARGB(217, 40, 43, 78),
                              border: InputBorder.none
                          ),
                          onChanged: (v){
                            setState(() {
                              searchText = v;
                              filterData = data.where((e) => e["nom"].toLowerCase().contains(v.toLowerCase())).toList();
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(45, 45)),
                          backgroundColor:
                              MaterialStatePropertyAll(Color.fromARGB(9, 135, 163, 246)),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                // boutons de filtre de donnees
                Container(
                  // color: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    child: Row(
                      children: [
                      btnFilter(
                          context: context,
                          onClick: () {
                            storage.setItem("data",{"name" : "waly testeur"});
                            setState(() {
                              _all = true;
                              _allWait = false;
                              _allAdmin = false;
                              _allAgent = false;
                              _allActif = false;
                              column = "nom";
                              colValue = "";
                            });
                          },
                          text: "Tout",
                          isActive: _all
                      ),
                      btnFilter(
                        context: context,
                        onClick: () {
                          setState(() {
                            _allAdmin = true;
                            _allAgent = false;
                            _allActif = false;
                            _allWait = false;
                            _all = false;
                            column = "acces";
                            colValue = "Agent";
                          });
                        },
                        text: "Admin",
                        isActive: _allAdmin,
                      ),
                      btnFilter(
                          context: context,
                          onClick: () {
                            setState(() {
                              _allAgent = true;
                              _allAdmin = false;
                              _allActif = false;
                              _allWait = false;
                              _all = false;
                              column = "acces";
                            colValue = "Admin";
                            });
                          },
                          text: "Agents",
                          isActive: _allAgent),
                      btnFilter(
                          context: context,
                          onClick: () {
                            setState(() {
                              _allActif = true;
                              _allAdmin = false;
                              _allAgent = false;
                              _allWait = false;
                              _all = false;
                              column = "isActive";
                              colValue = 0;
                            });
                          },
                          text: "Actifs",
                          isActive: _allActif
                          ),
                      btnFilter(
                          context: context,
                          onClick: () {
                            setState(() {
                              _allWait = true;
                              _allAdmin = false;
                              _allAgent = false;
                              _allActif = false;
                              _all = false;
                              column = "isActive";
                            colValue = 1;
                            });
                          },
                          text: "En att...",
                          isActive: _allWait
                      ),
                    ],
                    ),
                  ),
                ),
                // fin bouton de filtre de donnees
              ],
            ),
          ),
          // fin header recherche
          Container(
            // alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.only(bottom: 30, left: 8, right: 8),
            // padding: const EdgeInsets.all(10),
            decoration: containerDecoration(),
            child: StreamBuilder(
              stream: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  data = snapshot.data;
                  filterData = searchText != "" ? filterData : data;
                  return Column(
                    children: filterData.reversed.where((element) => element[column] != colValue)
                        .map(
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
                        )
                        .toList(),
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
          ),
        ],
      ),
    );
  }
}

Container btnFilter({required BuildContext context,String text = "click me",required void Function() onClick,bool isActive = true}) {
  return Container(
    margin: const EdgeInsets.only(right: 10),
    child: ElevatedButton(
      onPressed: onClick,
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          elevation: MaterialStatePropertyAll(0),
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.25,
        height: 40,
        decoration: BoxDecoration(
            color: isActive ? Colors.blue : const Color.fromARGB(104, 0, 0, 0),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Text(text),
      )),
  );
}
