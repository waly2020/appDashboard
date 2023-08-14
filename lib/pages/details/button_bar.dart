import 'package:dashboard/pages/details/delete_section.dart';
import 'package:dashboard/pages/details/update_form.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonAppBarIcon extends StatelessWidget {
  String action;
  Map<String,dynamic> user;
  bool activeModale;
  ButtonAppBarIcon({super.key,required this.action,required this.user,required this.activeModale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0x05000000),
          barrierColor: const Color(0x1AFFFFFF),
          showDragHandle: true,
          builder: (context){
            if(activeModale){
              return Container(
            padding: const EdgeInsets.all(20),
            // height: 200,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: const BorderRadius.only( topLeft:Radius.circular(20),topRight: Radius.circular(20)),
              boxShadow: [BoxShadow(
                offset: const Offset(0,-4),
                color: shadowColor,
              )]
            ),
            child: action == "d" ? DeleteSection(user: user,) : UpdateForm(user: user,),
          );
            }
            return const Text("pas de connexion");
          },
        );
      },
      style: const ButtonStyle(
        elevation: MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        padding: MaterialStatePropertyAll(EdgeInsets.zero)
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0x21000000),
          borderRadius: BorderRadius.all(Radius.circular(999))
        ),
        child: Icon(icons[action],size: 15,color: actionColor[action],),
      )
    ),
    );
  }
}

/*

Container(
            padding: const EdgeInsets.all(20),
            // height: 200,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: const BorderRadius.only( topLeft:Radius.circular(20),topRight: Radius.circular(20)),
              boxShadow: [BoxShadow(
                offset: const Offset(0,-4),
                color: shadowColor,
              )]
            ),
            child: action == "d" ? DeleteSection(user: user,) : UpdateForm(user: user,),
          )

*/