import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/widgets/widgets.dart';
import 'hero_widget.dart';


Widget CustomAppBar(BuildContext context, String title){
  final Color globalColor = Color.fromRGBO(255, 255, 255, 1.0);
  return  AppBar(
    backgroundColor: globalColor,
    elevation: 0,
    centerTitle: false,
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.drag_handle_outlined, color: Color.fromRGBO(0, 0, 0, 1.0),),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    ),
    actions: [
     Padding(
       padding: EdgeInsets.only(right: 20),
       child: Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 1.0),),
     )
   /*  Hero(
         tag: "profileTag",
         child: InkWell(
           child: Padding(
             padding: EdgeInsets.only(right: 20),
             child: CircleImage(
                 "images/img/profil.jpg", 25
             ),
           ),
           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HeroPage())),
         )
     )*/
    ],
  );
}