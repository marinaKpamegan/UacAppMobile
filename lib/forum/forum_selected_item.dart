
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uac_campus/utils/color_palette.dart';
import 'package:uac_campus/utils/forum_item.dart';
import 'package:uac_campus/widgets/bottom_navigation_bar.dart';
import 'package:uac_campus/widgets/custom_app_bar.dart';
import 'package:uac_campus/widgets/widgets.dart';

class ForumSelectedItem extends StatefulWidget{
  final ForumItem forumItem;
  const ForumSelectedItem(this.forumItem);
  @override
  ForumSelectedItemState createState(){
    return new ForumSelectedItemState();
  }
}

class ForumSelectedItemState extends State <ForumSelectedItem>{

  @override
  Widget build(BuildContext context) {
    final ForumItem forumItem = widget.forumItem;
    final DateFormat formatter = DateFormat.yMMMMd();
      return Scaffold(
        appBar: CustomAppBar(context, "Forum de discussion"),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(child: CircleImage("images/img/profil.jpg", 35), width: 40, height: 40,),
                            title: Text(forumItem.title, style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(forumItem.author),
                            trailing: IconButton(
                              onPressed: ()=>{
                                setState(() {
                                  forumItem.isFavorite = !forumItem.isFavorite;
                                  final snackBar = SnackBar(
                                    content: Text(forumItem.isFavorite ? 'Poste ajouté aux favoris' : 'Poste retiré des favoris'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                })
                              },
                              icon: Icon(Icons.favorite, color: forumItem.isFavorite?  Colors.redAccent: Colors.grey,) ,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 70),
                                child: Text('${forumItem.replies} réponses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text("${formatter.format(forumItem.time)}", style: TextStyle(fontSize: 10),),
                              )
                            ],
                          ),
                          Container(
                            child: Text(forumItem.resume),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(context, 2),
      );
  }
}