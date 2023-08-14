import 'package:dashboard/pages/content_pages/content_pages.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final passWord = TextEditingController();
  final mail = TextEditingController();
  bool seePassWord = true;
  @override
  void dispose() {
    super.dispose();
    passWord.dispose();
    mail.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 60,left: 10,right: 10,bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // titre
            const Text(
              "DASHBOARD",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,color: Colors.white,
                shadows: [
                 BoxShadow(color: Color(0x7D2195F3),blurRadius: 20),
                 BoxShadow(color: Color.fromARGB(255, 122, 118, 118),offset: Offset(0, 3)),
                ]
              ),
            ),
            // fin titre
            // form
            Container(
              padding: const EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 40),
              margin: const EdgeInsets.only(top: 30),
              decoration: containerDecoration(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    formInput(
                          label: "Adresse e-mail",
                          icon: Icons.email,
                          controller: mail,
                          validator: (value){
                            RegExp valideMail = RegExp(r"^[a-zA-Z0-9\-_]+@[a-zA-Z]+\.[a-z-A-Z]");
                            if(value == null ||valideMail.hasMatch(value) == false){
                              return "L'adresse mail n'est pas valide";
                            }
                            return null;
                          },
                      ),
                    const SizedBox(height: 20,),
                    formInput(
                          label: "Mot de passe",
                          icon: Icons.password_rounded,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: seePassWord,
                          controller: passWord,
                          validator: (value){
                            RegExp validePass = RegExp(r"^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])");
                            if(value == null || value.isEmpty){
                              return "Le champ mot de passe est vide";
                            }else if(validePass.hasMatch(value) == false){
                              return "Le mot de passe doit contenenir :\ndes nombres,des lettres majuscule et des lettres minuscule";
                            }else{
                              return null;
                            }
                          },
                      ),
                    // voir mot de pas
                      CheckboxMenuButton(
                          value: !seePassWord,
                          onChanged: (value) {
                            setState(() {
                              seePassWord = !value!;
                            });
                          },
                          child: const Text("Voir les mots de passe",
                              style: TextStyle(color: Colors.white)
                        )
                      ),
                      // fin voir mot de passe
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                       onPressed: () {
                        /**
                             "email" : "teste@gmail.com",
                             "password" : "walyledevflutter"
                         */
                            // _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate()) {
                              Map body = {
                                "email" : mail.text,
                                "password" : passWord.text
                              };
                              (() async{
                                final response = await http.post(
                                  Uri.parse("http://192.168.1.179:8001/api/auth/login"),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(body),
                                  );
                                  if(response.statusCode == 200){
                                    // storage.setItem("user", response.body);
                                    mainUser = jsonDecode(response.body);
                                     // ignore: use_build_context_synchronously
                                     Navigator.push(context, PageRouteBuilder(pageBuilder: (_,__,___) => const ContentPages()));
                                  }
                              })();
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                      child: const Text("Se connecter")
                    ),
                    )
                  ],
                ),
              ),
            )
            // fin form
          ],
        ),
      ),
      ),
    );
  }
}