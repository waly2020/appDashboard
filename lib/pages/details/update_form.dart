import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateForm extends StatefulWidget {
  Map<String,dynamic> user;
  UpdateForm({super.key, required this.user});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();

  bool _activeCount = false;
  bool _c = false;
  bool _u = false;
  bool _d = false;
  bool seePassWord = true;
  bool cliketSwitch = false;
  // ignore: prefer_typing_uninitialized_variables
  var _isAdmin;
  // ignore: prefer_final_fields
  List<String> _actions = ["r"];
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController teste = TextEditingController();

  _UpdateFormState(){
    // print(widget.user.nom);
    // _isAdmin = widget.user.acces == "Admin" ? true : false;
  }
  get user => widget.user;
  
  @override
  void dispose() {
    super.dispose();
    nom.dispose();
    prenom.dispose();
    passWord.dispose();
    mail.dispose();
    teste.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Modifier les information de l'utilisateur",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            // btn active
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                  color: Color(0x32000000),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Activé le compte",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  Switch(
                      value: _activeCount,
                      onChanged: (value) {
                        setState(() {
                          _activeCount = value;
                          cliketSwitch = true;
                        });
                      }),
                ],
              ),
            ),
            // fin btn active
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // nom
                  formInput(
                    label: "Nom (${widget.user['nom']})",
                    // defaultValue: "Waly",
                      controller: nom,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          nom.text = user.nom;
                        }
                        return null;
                      }),
                  // fin nom
                  const SizedBox(height: 20,),
                  // prenom
                  formInput(
                    label: "Prénom (${widget.user['prenom']})",
                    controller: prenom,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        prenom.text = user.prenom;
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
                    label: "Adresse e-mail (${widget.user['email']})",
                    icon: Icons.email,
                    controller: mail,
                    validator: (value) {
                      RegExp valideMail =
                      RegExp(r"^[a-zA-Z0-9\-_]+@[a-zA-Z]+\.[a-z-A-Z]");

                      if(value == null || value.isEmpty){
                        mail.text = user.email;
                      }
                      else if (valideMail.hasMatch(value) == false) {
                        return "L'adresse mail n'est pas valide";
                      }
                      return null;
                    },
                  ),
                  // fin E-mail
                  const SizedBox(height: 20,),
                  // // Acces
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: DropdownButtonFormField(
                      // enableFeedback: true,
                      // iconSize: 30,
                      // value: user.acces == "Admin" ? true : false,
                      style: const TextStyle(color: Colors.blue),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Color(0x69000000),
                      ),
                      decoration: decorationInput(
                          removeIcon: true,
                          label: "Droits d'acces de l'utilisateur (${widget.user['acces']})"
                      ),
                      items: const [
                        DropdownMenuItem(value: false, child: Text("Agent")),
                        DropdownMenuItem(value: true, child: Text("Adim")),
                      ],
                      validator: (value){
                        if(value == null){
                          _isAdmin = widget.user['acces'] == "Admin" ? true : false;
                          _u == false ? _actions.add("u") : null;
                          _d == false ? _actions.add("d") : null;
                          _c == false ? _actions.add("c") : null;
                        }
                        return null;
                      },
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

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if(cliketSwitch == false){
                            setState(() {
                              _activeCount = widget.user['isActive'] == 1 ? true : false;
                            });
                          }
                          // _formKey.currentState!.validate();
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Envoie en cours...")));
                          }
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Text("Mettre ${widget.user['nom']} à jour")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}