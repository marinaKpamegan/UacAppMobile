//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:uac_campus/student/about_identity_pages/student_fiche.dart';
import 'package:uac_campus/student/about_validation_pages/student_validation.dart';
import 'widgets/splash_screen.dart';


void main() =>
    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/fiche': (context) => StudentFiche(),
        '/validation': (context) => Validation(),
      },
      // home: MyApp(),

    ));


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen();
  }
}

