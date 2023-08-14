import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:dashboard/api/add_useer.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  bool _activeCount = false;
  bool _c = false;
  bool _u = false;
  bool _d = false;
  bool seePassWord = true;
  // ignore: prefer_typing_uninitialized_variables
  var _isAdmin;
  // ignore: prefer_final_fields
  List<String> _actions = ["r"];
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final passWord = TextEditingController();
  final mail = TextEditingController();
  final confirmPassWord = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nom.dispose();
    prenom.dispose();
    passWord.dispose();
    mail.dispose();
    confirmPassWord.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouté un utilisateur"),
        backgroundColor: secondColor,
        elevation: 0,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // nom
                      formInput(
                          controller: nom,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le nom ne peut pas être vide.";
                            }
                            return null;
                          }),
                      // fin nom
                      const SizedBox(
                        height: 20,
                      ),
                      // prenom
                      formInput(
                        label: "Prénom",
                        controller: prenom,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le prénom ne peut pas être vide.";
                          }
                          return null;
                        },
                      ),
                      // fin prenom
                      // E-mail
                      const SizedBox(
                        height: 20,
                      ),
                      formInput(
                        label: "Adresse e-mail",
                        icon: Icons.email,
                        controller: mail,
                        validator: (value) {
                          RegExp valideMail =
                              RegExp(r"^[a-zA-Z0-9\-_]+@[a-zA-Z]+\.[a-z-A-Z]");
                          if (value == null ||
                              valideMail.hasMatch(value) == false) {
                            return "L'adresse mail n'est pas valide";
                          }
                          return null;
                        },
                      ),
                      // fin E-mail
                      // Mot de passe
                      const SizedBox(
                        height: 20,
                      ),
                      formInput(
                        label: "Mot de passe",
                        icon: Icons.password_rounded,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: seePassWord,
                        controller: passWord,
                        validator: (value) {
                          RegExp validePass =
                              RegExp(r"^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])");
                          if (value == null || value.isEmpty) {
                            return "Le champ mot de passe est vide";
                          } else if (validePass.hasMatch(value) == false) {
                            return "Le mot de passe doit contenenir :\ndes nombres,des lettres majuscule et des lettres minuscule";
                          } else {
                            return null;
                          }
                        },
                      ),
                      // fin Mot de passe
                      // Confirmer mot de passe
                      const SizedBox(
                        height: 20,
                      ),
                      formInput(
                        label: "Confirmer le mot de passe",
                        icon: Icons.password_rounded,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: seePassWord,
                        controller: confirmPassWord,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entré le mot de passe de confirmation";
                          } else if (value != passWord.text) {
                            return "Les deux mots de passe sont different";
                          } else {
                            return null;
                          }
                        },
                      ),
                      // fin confirmer mot de passe
                      // voir mot de pas
                      CheckboxMenuButton(
                          value: !seePassWord,
                          onChanged: (value) {
                            setState(() {
                              seePassWord = !value!;
                            });
                          },
                          child: const Text("Voir les mots de passe",
                              style: TextStyle(color: Colors.white))),
                      // fin voir mot de passe
                      const SizedBox(
                        height: 20,
                      ),
                      // // Acces
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: DropdownButtonFormField(
                          // enableFeedback: true,
                          // iconSize: 30,
                          style: const TextStyle(color: Colors.blue),
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Color(0x69000000),
                          ),
                          decoration: decorationInput(
                              removeIcon: true,
                              label: "Droits d'acces de l'utilisateur"),
                          items: const [
                            DropdownMenuItem(
                                value: false, child: Text("Agent")),
                            DropdownMenuItem(value: true, child: Text("Adim")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _isAdmin = true;
                                _u == false ? _actions.add("u") : null;
                                _d == false ? _actions.add("d") : null;
                                _c == false ? _actions.add("c") : null;
                              } else if (value == false) {
                                _isAdmin = false;
                                _u == false ? _actions.remove("u") : null;
                                _d == false ? _actions.remove("d") : null;
                                _c == false ? _actions.remove("c") : null;
                              }
                            });
                          },
                        ),
                      ),
                      // fin Acces
                      // btn active
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                            color: Color(0x13000000),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Activé le compte",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            Switch(
                                value: _activeCount,
                                onChanged: (value) {
                                  setState(() {
                                    _activeCount = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                      // fin btn active
                      // titre checkbox
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "*Actions de l'utilisateur",
                          style: TextStyle(
                              color: Color.fromARGB(255, 252, 94, 82),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // fin titre checkbox
                      // checkbox
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          color: const Color(0x3D000000),
                          child: Row(
                            children: [
                              CheckboxMenuButton(
                                value: _isAdmin == true ? true : _u,
                                onChanged: (value) {
                                  setState(() {
                                    if (_isAdmin != true) {
                                      _u = value!;
                                      if (value) {
                                        _actions.add("u");
                                      } else {
                                        _actions.remove("u");
                                      }
                                    }
                                  });
                                },
                                child: const Text(
                                  "Modifier",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              CheckboxMenuButton(
                                  value: _isAdmin == true ? true : _d,
                                  onChanged: (value) {
                                    setState(() {
                                      if (_isAdmin != true) {
                                        _d = value!;
                                        if (value) {
                                          _actions.add("d");
                                        } else {
                                          _actions.remove("d");
                                        }
                                      }
                                    });
                                  },
                                  child: const Text("Supprimer",
                                      style: TextStyle(color: Colors.blue))),
                              CheckboxMenuButton(
                                  value: _isAdmin == true ? true : _c,
                                  onChanged: (value) {
                                    setState(() {
                                      if (_isAdmin != true) {
                                        _c = value!;
                                        if (value) {
                                          _actions.add("c");
                                        } else {
                                          _actions.remove("c");
                                        }
                                      }
                                    });
                                  },
                                  child: const Text("Ajouter",
                                      style: TextStyle(color: Colors.blue))),
                              CheckboxMenuButton(
                                  value: true,
                                  onChanged: (value) {},
                                  child: const Text("Lecture",
                                      style: TextStyle(color: Colors.blue))),
                            ],
                          ),
                        ),
                      ),
                      // fin checkbox
                      // bouton d'envoie
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                // _formKey.currentState!.validate();
                                if (_formKey.currentState!.validate()) {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text("En cours de création..."))
                                  );
                                
                                Map body = {"nom" : nom.text,"prenom" : prenom.text,"email" : mail.text,"acces" : _isAdmin == true ? "Admin" : "Agent","actions" : "$_actions","isActive" : _activeCount == true ? 1 : 0,"password" : passWord.text};

                                (() async {
                                  final response = await http.post(
                                    Uri.parse("http://192.168.1.179:8001/api/auth/create"),
                                    headers: <String, String>{'Content-Type':'application/json; charset=UTF-8',},
                                    body: jsonEncode(body),
                                  );
                                  if (response.statusCode == 201) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text("L'utilisateur a bien ete cree"))
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text("Utilisateur non cree"))
                                  );
                                  }
                                })();
                                setState(() {
                                  nom.text = "";
                                  prenom.text = "";
                                  mail.text = "";
                                  passWord.text = "";
                                  seePassWord = true;
                                  _isAdmin = false;
                                  _activeCount = false;
                                  confirmPassWord.text = "";
                                });
                                }
                              },
                              child: const Text("Créé le compte"),
                            ),
                      )
                      // fin bouton d'envoie
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
/*
FutureBuilder(
                                future: addUser({"nom" : nom.text,"prenom" : prenom.text,"email" : mail.text,"acces" : _isAdmin == true ? "Admin" : "Agent","actions" : "$_actions","isActive" : _activeCount == true ? 1 : 0,"password" : passWord.text}),
                                builder: (context, snapshot){
                                  print("Builder a ete appeler");
                                  if(snapshot.hasError){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                     content: Text("L'utilisateur as bien etet cree"))
                                    );
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                     content: Text("Utilisateur non cree"))
                                    );
                                  }
                                  
                                return const SizedBox();
                                },
                              )
*/
/**
 * ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Envoie en cours..."))
                              );
                              // ignore: unrelated_type_equality_checks
                              if(user == false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                  content: Text("Utilisateur non cree"))
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Utilisateur cree")
                                  )
                              );
                              }
 */