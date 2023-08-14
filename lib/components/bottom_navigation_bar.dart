import 'package:dashboard/pages/forms/form_page.dart';
import 'package:dashboard/components/widgets.dart';
import 'package:dashboard/pages/home/home.dart';
import 'package:dashboard/pages/liste/list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BarNavigation extends StatelessWidget {
  int index;
  BarNavigation({super.key,this.index = 0});

  @override
  Widget build(BuildContext context) {
    return ContainerBlock(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        radius: 10,
        content: GNav(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          gap: 20,
          selectedIndex: index,
          color: Colors.grey,
          activeColor: Colors.blue,
          tabBackgroundColor: Colors.white,
          tabActiveBorder: Border.all(color: const Color(0xFFE8E9EB),width: 2),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            text: "Accueil",
            onPressed: () => {index == 0 ? null : Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const HomePage())))},
          ),
          GButton(
            icon: Icons.apps_outlined,
            text: "Liste",
            // active: index == 1 ? true : false,
            onPressed: () => {index == 1 ? null : Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const ListePage())))},
          ),
          GButton(
            icon: Icons.add_card_rounded,
            text: "Ajouter",
            onPressed: () => {index == 2 ? null : Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const FormPage())))},
          ),
          const GButton(icon: Icons.perm_contact_calendar,text: "Compte",active: true,),
        ],
      ),
      );
  }
}