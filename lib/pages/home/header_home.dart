import 'package:dashboard/api/get_one_user.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
// HeaderHome
class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {

  late Stream userDtas;
  @override
  void initState() {
    super.initState();
    userDtas = Stream.periodic(const Duration(seconds: 2)).asyncMap((event) async => await getOneUser(mainUser["id"]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30,bottom: 50),
      // height: (MediaQuery.of(context).size.height * 0.3) + MediaQuery.of(context).padding.top,
      decoration: containerDecoration(),
      child: StreamBuilder(
        stream: userDtas,
        builder: (context, snapshot){
          if(snapshot.hasData){
            Map user = snapshot.data;
           return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user["acces"],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          // icon user
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: user['isActive'] == 1 ? userActive : userDisable,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [BoxShadow(
                offset: const Offset(0, 3),
                color: user['isActive'] == 1 ? const Color.fromARGB(93, 112, 231, 116) : const Color(0x77E77E70),
              )]
            ),
            child: const Icon(Icons.manage_accounts,size: 30,color: Colors.white,),
          ),
          // fin icon user
          Text("${user['nom']} ${user['prenom']}",style: const TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
          Text(user['email'],style: const TextStyle(color: Colors.white,fontSize: 13),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actionsUser.map((e) => 
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20,right: 10,left: 10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(68, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(99))
              ),
              child: Icon(icons[e],size: 18,color: const Color(0xA1FFFFFF),),
            ),
            ).toList(),
          ),
        ],
      );
          }else{
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}