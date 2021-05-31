import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/menu.dart';
import 'package:uac_campus/widgets/widgets.dart';
import '../student/about_validation_pages/student_validation.dart';


Widget CustomDrawer(BuildContext context, String currentRoute){
  Color active =  Color.fromRGBO(35, 154, 105, 0.25);
  String iconPath = "assets/images/icons";
  double height = MediaQuery.of(context).size.height;
  if(currentRoute == null){
    currentRoute = "/fiche";
  }
  return ClipRRect(
    borderRadius: BorderRadius.only(topRight: Radius.circular(45), bottomRight: Radius.circular(45)),
    child: Drawer(
      elevation: 25,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: CircleImage(
                      "images/img/profil.jpg", 60
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: Text('KPAMEGAN Falonne Marina', style: TextStyle(fontSize: 16, color: Colors.white), softWrap: true,)),
                      Container(child: Text('falonne.kpame83 ', style: TextStyle(fontSize: 10, color: Colors.white), softWrap: true,),),
                      Container(child: Text('18825618', style: TextStyle(fontSize: 10, color: Colors.white), softWrap: true,),),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(35, 154, 105, 1), Color.fromRGBO(9, 113, 52, 1)])
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              title: Text('Acceuil'),
              leading: Icon(Icons.home_sharp),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: currentRoute == "/fiche" ? active: null
            ),
            child: ListTile(
              title: Text('Ma fiche'),
              leading: Image.asset("$iconPath/graduated.png", width: 20, height: 20,),
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Validation()),
                );*/
                Navigator.pushNamed(context, "/fiche");
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: currentRoute == "/validation" ? active: null
            ),
            child: ListTile(
              title: Text('Inscriptions'),
              leading: Icon(Icons.done_all, color: Colors.black,),
              onTap: () {
                Navigator.pushNamed(context, "/validation");
              },
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: null
              ),
            child: ListTile(
              title: Text('Programmes'),
              leading: Image.asset("$iconPath/educational-programs.png", width: 20, height: 20,),
              onTap: () {
                Navigator.pushNamed(context, "/validation");
              },
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: null
            ),
            child: ListTile(
              title: Text('Parcours académique'),
              leading: Image.asset("$iconPath/educational-programs.png", width: 20, height: 20,),
              onTap: () {
                Navigator.pushNamed(context, "/validation");
              },
            ),
          ),
         Container(
             margin: EdgeInsets.symmetric(horizontal: 8),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 color: null
             ),
           child:  ListTile(
             title: Text('Sanctions'),
             leading: Image.asset("$iconPath/auction.png", width: 20, height: 20,),
             onTap: () {
               Navigator.pushNamed(context, "/validation");
             },
           )
         ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: null
              ),
            child: ListTile(
              title: Text('Comptabilités'),
              leading: Image.asset("$iconPath/school.png", width: 20, height: 20,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Validation()),
                );
              },
            )
          ),

          Container(
            margin: EdgeInsets.only(top: height > 700 ? height - 680 : height - 500),
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: Image.asset("$iconPath/logout.png", width: 20, height: 20,),
              title: Text('Déconnexion'),
              onTap: () {
                Navigator.pushNamed(context, "/validation");
              },
            ),
          )
        ],
      ),
    ),
  );

}
