import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// local storage
final LocalStorage storage = LocalStorage("user");
// storage.setItem("data", "hello");

Color mainColor = const Color(0xFF282B4E);
Color secondColor = const Color(0xFF363868);
Color userActive = const Color(0xFF70E774);
Color userDisable = const Color(0xFFE77E70);
Color contentWidgetColor = const Color(0xFFF1F2F9);
Color shadowColor = const Color(0x08F4F4F4);
double paddingPage = 10;
// icons action des users
Map icons = {
  "c": Icons.add,
  "r": Icons.remove_red_eye_outlined,
  "u": Icons.edit,
  "d": Icons.delete,
};
Map actionText = {
  "c": "Ajouter des utilisateurs",
  "r": "Voir les utilisateur",
  "u": "modifier les utilisateurs",
  "d": "Supprimer des utilisateurs",
};
Map actionColor = {
  "c": Colors.blue,
  "r": Colors.blue,
  "u": Colors.white,
  "d": Colors.red,
};
List<String> actionsUser = ['c','r','u','d'];

List<String> getActions(String actions){
    List<String> ac = actionsUser.where((element) => actions.contains(element)).toList();
    return ac;
  }
BoxDecoration containerDecoration() {
  return BoxDecoration(
      color: secondColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        const BoxShadow(
          blurRadius: 10,
          color: Color.fromARGB(82, 0, 0, 0),
        ),
        BoxShadow(
          offset: const Offset(0, 4),
          color: shadowColor,
        ),
      ]);
}
InputDecoration decorationInput({String label = "nom",IconData icon = Icons.account_circle,bool removeIcon = false}){
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Color.fromARGB(122, 255, 255, 255)),
    border: InputBorder.none,
    fillColor: const Color.fromARGB(54, 0, 0, 0),
    filled: true,
    suffixIcon: removeIcon ? null : Icon(icon),
    contentPadding: const EdgeInsets.all(15)
  );
}
ClipRRect formInput({String label = "Nom",IconData icon = Icons.account_circle,bool removeIcon = false,bool obscureText = false,bool enableSuggestions = true,bool autocorrect = true,TextEditingController? controller,String? Function(String?)? validator,String? defaultValue}){
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: TextFormField(
      style: const TextStyle(color: Colors.blue),
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      controller: controller,
      validator: validator,
      initialValue: defaultValue,
      decoration: decorationInput(label: label,icon: icon,removeIcon: removeIcon),
    ),
  );
}
class Users {
  int id = 0;
  int userId;
  String nom;
  String prenom;
  String email;
  String acces;
  int isActive;
  String actions;

  Users({
    this.id = 0,
    this.isActive = 0,
    this.userId = 0,
    this.nom = "Waly",
    this.prenom = "LE DEV",
    this.email = "walyledev@gmail.com",
    this.acces = "Admin",
    this.actions = "['c', 'r', 'u','d']"
  });

  factory Users.fromJson(List<Map<String,dynamic>> json) {
    // Map user = jsonDecode(json);
    return Users(
      // id: json['id'],
      // nom: json['nom'],
      // prenom: json['prenom'],
      // email: json['email'],
      // acces: json['acces'],
      // actions: json['actions'],
      // isActive: json['isActive'] == 1 ? true : false,
    );
  }
}

Map<String,dynamic> mainUser = {};

    