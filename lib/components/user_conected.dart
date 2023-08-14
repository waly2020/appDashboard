import 'package:dashboard/utils/utils.dart';
// import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserConected extends StatelessWidget {
  bool addDecoration;
  BoxDecoration decoration;
  EdgeInsets padding;
  EdgeInsets margin;
  String nom;
  String prenom;
  String email;
  String acces;
  int isActive;
  String actions;
  void Function() onPressed;
  UserConected({super.key,this.nom = "Mintsa",this.prenom = "Jean-Bosco",this.email = "mintsa@gmain.com",this.acces = "Agent",this.actions = '["c","r","u","d"]',this.isActive = 1,this.addDecoration = false,this.decoration = const BoxDecoration(),this.margin = const EdgeInsets.all(0),this.padding = const EdgeInsets.all(0),required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // boxHeight: 100,
        padding: padding,
        margin: margin,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0x13000000),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            shadowColor: MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStatePropertyAll(0),
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            // foregroundColor: MaterialStatePropertyAll(Colors.transparent),

          ),
          child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(104, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                    ),
                    child: Icon(acces == "Admin" ? Icons.manage_accounts : Icons.settings,color: Colors.blue,),
                  ),
                   Positioned(
                    bottom: 0,
                    left: 0,
                    width: 70,
                    child: Transform.translate(
                      offset: const Offset(0,10),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: containerDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(acces,style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1,color: isActive == 1 ? userActive : userDisable),)],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("$nom $prenom",style: const TextStyle(color: Colors.blue,fontSize: 20)),
                    const SizedBox(height: 5,),
                    Text(email,style: const TextStyle(color: Color.fromARGB(255, 233, 233, 233),)),
                    const SizedBox(height: 8),
                    Row(
                    
                    children: getActions(actions).map((e) =>
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(89, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        child: Icon(icons[e],color: const Color(0xFFE0DFDF),size: 15,),
                      ),
                    ).toList(),
                  ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                    color: isActive == 1 ? userActive : userDisable,
                      borderRadius: const BorderRadius.all(Radius.circular(99)),
                      boxShadow: const [BoxShadow(spreadRadius: 5,color: Color.fromARGB(60, 0, 0, 0))]
                    ),
                  ),
                )
              ],
            ),
            )
              // fin information utilisateur connecter
              
          ],
        ),
        ),
      );
  }
}