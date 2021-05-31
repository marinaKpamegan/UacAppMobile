import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/map/map.dart';
import 'package:uac_campus/middle_page.dart';
import 'package:uac_campus/models/uac_locations.dart';
import 'package:uac_campus/widgets/rss_feed_carousel_slider.dart';
import 'package:uac_campus/services/rss_feed.dart';
import 'package:uac_campus/settings/settings.dart';
import 'package:uac_campus/widgets/web_page_opener.dart';
import 'package:webfeed/webfeed.dart';

import 'student/about_identity_pages/student_fiche.dart';


class Menu extends StatefulWidget {

  @override
  MenuState createState() {
    return new MenuState();
  }

}

class MenuState extends State<Menu>{
  RssFeed feed;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await UacRssService().getFeed().then((value){
        setState(() {
          feed = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color globalColor = Color.fromRGBO(4, 57, 102, 1);
    UacLocation rectorat = new UacLocation("Rectorat Annexe", "Rectorat Annexe de l'UAC", 6.415, 2.34345, "Rectorat");
    int selectedIndex;
    // tiles list initialization
    List<_MenuTile> _menuTiles = [
      _MenuTile("map 1.png", "Carte", Color.fromRGBO(9, 113, 52, 1),/*UacMap(rectorat)*/ null),
      _MenuTile("website.png", "UAC", Color.fromRGBO(16, 135, 87, 1),WebPageContainer("UAC", "https://uac.bj/")),
      _MenuTile("graduate 1.png", "Mes Etudes", Color.fromRGBO(35, 154, 105, 1), StudentFiche()),// replace by Middle Page
      _MenuTile("capmenu.png", "Moodle", Color.fromRGBO(15, 162, 76, 1), WebPageContainer("Moodle", "https://elearning.uac.bj/")),
      _MenuTile("earth-grid 1.png", "Web TV", Color.fromRGBO(9, 113, 52, 1), WebPageContainer("Web TV", "https://webtv.uac.bj/")),
    ];


    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'UAC Campus',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.black,),
                    onPressed: (){

                    },
                  ),
                  Positioned(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(252, 95, 93, 1),
                            shape: BoxShape.circle
                        ),
                      ),
                      left: 25,
                      top: 10
                  ),
                ],
              ),
            )
          ],
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: FutureBuilder<RssFeed>(
                      future: callAsyncFetch(),
                      builder: (BuildContext context, AsyncSnapshot<RssFeed> snapshot){
                          if(snapshot.hasData){
                            return RssFeedCarousel(feed);
                          }else if(snapshot.hasError){
                            return Container(
                              alignment: Alignment.center,
                              height: 200,
                              width: MediaQuery.of(context).size.width - 10,
                              color: Color.fromRGBO(4, 57, 102, 1),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 100,
                                    width: 300,
                                    child: Text("Impossible de charger. Une erreur est suvenue", style: TextStyle(color: Colors.white,),softWrap: true,),
                                  )
                              ),
                            );
                          }else{
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width - 10,
                              color: Color.fromRGBO(4, 57, 102, 1),
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                )
                              ),
                            );
                          }
                      },
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 15,
                    child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child:  Text("News", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      color: Color.fromRGBO(35, 154, 105, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                  padding: EdgeInsets.only(top: 15),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15),
                    children: List.generate(_menuTiles.length, (index){
                      return Container(
                        child: _menuTiles[index],
                      );
                    }),
                  )
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
    );
  }

  Future<RssFeed> callAsyncFetch() => Future.delayed(Duration(seconds: 5), () => UacRssService().getFeed());

}

class _MenuTile extends StatelessWidget{
  const _MenuTile(this.iconData, this.text, this.color, this.target);

  final String iconData;
  final String text;
  final Color color;
  final Widget target;

  @override
  Widget build(BuildContext context) {
     return InkWell(
       child: Card(
         margin: EdgeInsets.all(10),
         elevation: 15,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8),
         ),
         shadowColor: Colors.blueAccent.withOpacity(0.3),
         color: color,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 10,),
             Image.asset("assets/images/icons/$iconData", width: 30, height: 30),
             SizedBox(height: 8,),
             Text(text, style: TextStyle(color: Colors.white, fontSize: 15),),
             SizedBox(height: 20,),
           ],
         ),
       ),
       onTap: (){
         Navigator.push(
             context,
             PageRouteBuilder(
                 transitionDuration: Duration(milliseconds: 400),
                 pageBuilder: (
                     BuildContext context,
                     Animation<double> animation,
                     Animation<double> secondaryAnimation) {
                   return target;
                 },
                 transitionsBuilder: (
                     BuildContext context,
                     Animation<double> animation,
                     Animation<double> secondaryAnimation,
                     Widget child,
                     ) {

                   return  SlideTransition(
                     position: Tween<Offset>(
                       begin: const Offset(0, 1),
                       end: Offset.zero,
                     ).animate(animation),
                     child: child,
                   );
                 }

             )
         );
       },
     );
  }
}

