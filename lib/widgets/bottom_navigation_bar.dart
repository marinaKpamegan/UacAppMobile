import 'package:flutter/material.dart';
import 'package:uac_campus/forum/forum.dart';
import 'package:uac_campus/menu.dart';
import 'package:uac_campus/student/about_identity_pages/student_fiche.dart';
import 'package:uac_campus/utils/color_palette.dart';


// ignore: non_constant_identifier_names
Widget BottomNavigationBarWidget(BuildContext context, int currentIndex)  {
  List<Widget> pages = [
    Forum(),
    StudentFiche(),
    Menu()
  ];
  return BottomNavigationBar(
    selectedItemColor: ColorPalette.blueGreen.colorPalette,
    currentIndex: currentIndex,
    onTap: (index) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => pages.elementAt(currentIndex)));
    },
    items: [
      BottomNavigationBarItem(
          icon: currentIndex == 0 ? Icon(Icons.home,):Icon(Icons.home_outlined,),
          label: "Acceuil",
      ),
      BottomNavigationBarItem(
          icon: currentIndex == 1 ? Icon(Icons.person):Icon(Icons.person_outline_outlined),
          label: "Mes infos"
      ),
      BottomNavigationBarItem(
          icon: currentIndex == 2 ? Icon(Icons.forum):Icon(Icons.forum_outlined),
          label: "Forum"
      ),
    ],
  );
}