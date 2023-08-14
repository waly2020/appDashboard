import 'package:dashboard/pages/forms/form_page.dart';
import 'package:dashboard/pages/home/home.dart';
import 'package:dashboard/pages/liste/list.dart';
import 'package:dashboard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ContentPages extends StatefulWidget {
  const ContentPages({super.key});

  @override
  State<ContentPages> createState() => _ContentPgaeState();
}

class _ContentPgaeState extends State<ContentPages> {
  int _currentPage = 0;
  setCurrentPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Admin',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: mainColor,
        // body
        body: [
          const HomePage(),
          const ListePage(),
        ][_currentPage],
        // fin body
        // floatin button
        floatingActionButton: mainUser['actions'].contains("c")
            ? FloatingActionButton(
              // elevation: 0,
              backgroundColor: Colors.transparent,
                onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const FormPage(),
                    )),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(color: Color(0x6D2195F3),blurRadius: 20),
                      BoxShadow(offset: Offset(0,3),color: Color(0x6D2195F3)),
                    ]
                  ),
                  child: Icon(icons["c"],size: 30,),
                ),
              )
            : null,
        // bottom bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.all(10),
          decoration: containerDecoration(),
          child: GNav(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            // backgroundColor: Colors.red,
            gap: 20,
            selectedIndex: _currentPage,
            onTabChange: (value) => setCurrentPage(value),
            color: Colors.white,
            activeColor: Colors.blue,
            tabBackgroundColor: const Color(0x60000000),
            duration: const Duration(milliseconds: 800),
            // curve: Curves.linear,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: "Accueil",
              ),
              GButton(
                icon: Icons.apps_outlined,
                text: "Liste",
              ),
              // GButton(
              //   icon: Icons.add_card_rounded,
              //   text: "Ajouter",
              // ),
              // GButton(
              //   icon: Icons.perm_contact_calendar,
              //   text: "Compte",
              //   active: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
