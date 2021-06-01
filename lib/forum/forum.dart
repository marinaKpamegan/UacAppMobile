import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uac_campus/utils/color_palette.dart';
import 'package:uac_campus/utils/forum_item.dart';
import 'package:uac_campus/widgets/bottom_navigation_bar.dart';
import 'package:uac_campus/widgets/custom_app_bar.dart';

class Forum extends StatefulWidget{

  @override
  ForumState createState() {
    return new ForumState();
  }

}

class ForumState extends State<Forum>{
  int _selected;
  List <ForumItem> forumItems;

  @override
  void initState() {
    super.initState();
    _selected = 0;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = [
      Tab(
          text: "Récents"
      ),
      Tab(
        text: "Favoris",
      ),
    ];
    List<Widget> pages = [
      Container(),

    ];

    return Scaffold(
      appBar: CustomAppBar(context, "Forum"),
      body: SafeArea(
        child:  DefaultTabController(
          initialIndex: 0,
          length: pages.length,
          child: Column(
            children: [
              SizedBox(height: 15,),
              Center(
                child: ButtonsTabBar(
                  backgroundColor: ColorPalette.blueGreen.colorPalette,
                  unselectedBackgroundColor: Colors.white,
                  labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                      color: ColorPalette.blueGreen.colorPalette, fontWeight: FontWeight.bold),
                  borderWidth: 1,
                  unselectedBorderColor: null,
                  contentPadding: EdgeInsets.symmetric(horizontal:15),
                  radius: 100,
                  tabs: tabs,
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: TabBarView(
                    children: [
                      pages.elementAt(0),
                      pages.elementAt(1)
                    ],
                  )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(context, 2),
    );
  }
  onButtonTap(int index) {
    setState(() {
      _selected = index;
    });
  }

  Widget forumTopics(ForumItem forumItem){
    return Container(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int value){
                    return Container();
                  }
              )
          );
  }
}
