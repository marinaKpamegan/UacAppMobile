import 'package:flutter/material.dart';


Widget BottomNavigationBarWidget(BuildContext context, int currentIndex)  {
  return BottomNavigationBar(
    iconSize: 20,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.black,
    selectedFontSize: 18,
    selectedIconTheme: IconThemeData(size: 30),
    selectedItemColor: Color.fromRGBO(35, 154, 105, 1.0),
    currentIndex: currentIndex,
    onTap: (index) {

    },
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,),
          label: "Acceuil",
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: "Moi"
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.forum_outlined,
          ),
          label: "Forum"
      ),
    ],
  );
}