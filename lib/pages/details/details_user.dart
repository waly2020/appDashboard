import 'package:dashboard/api/get_one_user.dart';
import 'package:dashboard/pages/details/button_bar.dart';
import 'package:dashboard/pages/details/user_info_list.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsUser extends StatefulWidget {
  Map<String, dynamic>? user;
  DetailsUser({super.key, this.user});

  @override
  State<DetailsUser> createState() => _DetailsUserState();
}

class _DetailsUserState extends State<DetailsUser> {
  // Map<String, dynamic>? user;
  bool activeBtn = true;
  late Stream apiUser;
  @override
  void initState() {
    super.initState();
    apiUser = Stream.periodic(const Duration(seconds: 2)).asyncMap((event) async => await getOneUser(widget.user!["id"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details utilisateur"),
        backgroundColor: secondColor,
        elevation: 0,
        actions: [
          Row(
            children: actionsUser.map((e) {
              return (e == "d" || e == "u") && activeBtn
                  ? ButtonAppBarIcon(action: e, user: widget.user!,activeModale: activeBtn,)
                  : const SizedBox();
            }).toList(),
          )
        ],
        // toolbarHeight: 100,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: apiUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                activeBtn = true;
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(77, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          UserInfoList(
                            label: "Nom",
                            value: snapshot.data['nom'],
                          ),
                          UserInfoList(
                            label: "Prenom",
                            value: snapshot.data['prenom'],
                          ),
                          UserInfoList(
                            label: "e-mail",
                            value: snapshot.data['email'],
                          ),
                          UserInfoList(
                            label: "Acces",
                            value: snapshot.data['acces'],
                          ),
                          UserInfoList(
                            label: "Staut du compte",
                            value: snapshot.data['isActive'] == 1
                                ? "Actif"
                                : "En att...",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(77, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Actions",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 246, 152, 11)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: getActions(snapshot.data['actions'])
                                .map((e) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            actionText[e],
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          Icon(
                                            icons[e],
                                            color: Colors.orange,
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                activeBtn = false;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: Icon(Icons.signal_wifi_connected_no_internet_4_sharp,color: secondColor,size: 70,),
                );
              }
              activeBtn = true;
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(77, 0, 0, 0),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const CircularProgressIndicator(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
/*
UserInfoList(label: "Nom",value: snapshot.data['nom'],),
                          UserInfoList(label: "Prenom",value: snapshot.data['prenom'],),
                          UserInfoList(label: "e-mail",value: snapshot.data['email'],),
                          UserInfoList(label: "Acces",value: snapshot.data['acces'],),
                          UserInfoList(label: "Staut du compte",value: snapshot.data['isActive'] == 1 ? "Actif" : "En att...",),




                          StreamBuilder(
                    stream: apiUser,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        user = snapshot.data;
                        return Column(
                          children: [
                          
                        ],);
                      }else{
                        print(snapshot.error);
                        return Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    },
                  )
*/
/**
 * Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                  margin: const EdgeInsets.only(top: 30,bottom: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(77, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      Text("data"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(77, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Actions",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 246, 152, 11)),),
                      const SizedBox(height: 10,),
                      Column(
                        children: getActions(user!['actions']).map((e) => 
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(actionText[e],style: const TextStyle(fontSize: 17,color: Colors.white),),
                              Icon(icons[e],color: Colors.orange,)
                            ],
                          ),
                        )
                        ).toList(),
                      ),
                    ],
                  ),
                )
 */