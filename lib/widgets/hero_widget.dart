import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/services/rss_feed.dart';
import 'package:webfeed/webfeed.dart';
import '../menu.dart';

class HeroPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(4, 57, 102, 1),
        leading: Padding(
          padding: EdgeInsets.only(left: 12),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Hero(
        tag: 'profileTag',
        child: Center(
          child: FlutterLogo(
            size: 100,
          ),
        )
      ),
    );
  }

}