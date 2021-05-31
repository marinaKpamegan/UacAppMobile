import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/services/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import '../menu.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Menu())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
       children: [
         Container(
           child: Container(
             color: Colors.white.withOpacity(1),
             child:  Center(
               child: Image.asset('assets/images/icons/cap.png', width: 150, height: 150,),
             ),
           ),
           decoration: BoxDecoration(

           ),
         ),
         Positioned.fill(
           bottom: 0,
           child: Align(
             alignment: Alignment.bottomCenter,
             child: Padding(
               padding: EdgeInsets.only(bottom: 50),
               child: Text(
                 "Uac Mobile",
                 style: TextStyle(
                     color: Color.fromRGBO(4, 57, 102, 1),
                     fontFamily: "PoiretOne",
                     fontWeight: FontWeight.bold,
                     fontSize: 30),
               ),
             )
           ),
         )
       ],
      ),
    );
  }

}