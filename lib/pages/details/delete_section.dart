// import 'dart:convert';

import 'package:dashboard/pages/content_pages/content_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DeleteSection extends StatelessWidget {
  Map<String,dynamic> user;
  DeleteSection({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Text("Voulez-vous vraiment supprimer l'utilisateur ${user['nom']} ?",style: const TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center),
          // espace
          const SizedBox(height: 30,),
          // les boutons
          SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    (() async{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:Text("En cours..."),
                          behavior: SnackBarBehavior.floating,
                          dismissDirection: DismissDirection.up,
                        )
                      );
                      final response = await http.delete(
                        Uri.parse("http://192.168.1.179:8001/api/users/delete/${user['id']}"),
                        // body: jsonEncode({
                        //   "id" : 4,
                        // }),
                      );
                      if (response.statusCode == 200) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content:Text("L'utilisateur a bien ete supprimer"))
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (a,b,c) => const ContentPages()
                        )
                        );
                        
                      }else{
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:Text("Veiller verifier votre connexion..."),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                              dismissDirection: DismissDirection.up,
                            )
                        );
                        throw Exception("Utilisateur non cree");
                      }
                    })();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)
                  ),
                  child: const Text("Oui, je veux"),
                ),
              ),
          // fin les boutons
        ],
      ),
    );
  }
}