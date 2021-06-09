import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uac_campus/forum/forum_selected_item.dart';
import 'dart:core';
import 'package:uac_campus/utils/color_palette.dart';
import 'package:uac_campus/utils/forum_item.dart';
import 'package:uac_campus/widgets/bottom_navigation_bar.dart';
import 'package:uac_campus/widgets/custom_app_bar.dart';
import 'package:uac_campus/widgets/drawer.dart';
import 'package:uac_campus/widgets/widgets.dart';

class Forum extends StatefulWidget{

  @override
  ForumState createState() {
    return new ForumState();
  }

}

class ForumState extends State<Forum>{
  int _selected;
  List <ForumItem> forumItems = [
    ForumItem("Dépot de dossier", "John Doe", "Armanda Carim", "J'ai beaucoup de mal à remplir mes papiers", "Calme toi et lis bien", 3, DateTime(2021, 6, 1), false),
    ForumItem("Recherche du rectorat", "Alicia Keys", "Armanda Carim", "Direction du rectorat annexe", "cherche", 1, DateTime(2021, 5, 1), true)
  ];
  List<Widget> pages;
  @override
  void initState() {
    super.initState();
    _selected = 0;
    pages = [
      Container(
        child: forumTopicsAnimated(),
      ),
      Container(
        child: forumTopics(),
      ),
      Container(),
      Container(
        child: forumFavoritesPost(),
      ),
    ];
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final DateFormat formatter = DateFormat.yMMMMd();
  int _selectedItem;
  int _nextItem;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listFavoriteKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = [
      Tab(
        text: "Tous",
      ),
      Tab(
          text: "Récents"
      ),
      Tab(
        text: "Mes Posts",
      ),
      Tab(
        text: "Favoris",
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(context, "Forum de discussion"),
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
                      color: Colors.black, fontWeight: FontWeight.bold),
                  unselectedBorderColor: Colors.black12,
                  contentPadding: EdgeInsets.symmetric(horizontal:15),
                  radius: 100,
                  borderWidth: 1,
                  borderColor: ColorPalette.blueGreen.colorPalette,
                  tabs: tabs,
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: TabBarView(
                    children: [
                      pages.elementAt(0),
                      pages.elementAt(1),
                      pages.elementAt(2),
                      pages.elementAt(3)
                    ],
                  )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.blue.colorPalette,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Ajouter un poste'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.1)
                      ),
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: 'Titre',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez renseigner le titre';
                          }else{
                            return null;
                          }

                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.1)
                      ),
                      child: TextFormField(
                        controller: contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: 'Contenu du poste',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez renseigner le contenu du poste';
                          }else{
                            return null;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.attachment_outlined, color: ColorPalette.blue.colorPalette,),
                      onPressed: (){

                      }
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: ColorPalette.blue.colorPalette,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: (){

                        if (_formKey.currentState.validate()){
                          ForumItem item = new ForumItem(titleController.text, "", "User", contentController.text, "", 0, DateTime.now(), false);
                          _addItem(item);
                          Navigator.pop(context);
                        }else{
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Un problème est survenu'), backgroundColor: Colors.redAccent,));
                        }

                      },
                      label: Text("Envoyer"),
                      icon: Icon(Icons.send_outlined),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Annuler'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(context, 2),
      drawer: CustomDrawer(context, ""),
    );
  }
 /* void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    _list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }*/

  addToList(ForumItem item){
    setState(() {
      forumItems.add(item);
      print(forumItems.length);
    });
  }

  Widget forumTopics(){
    return ListView.builder(
      itemCount: forumItems.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int value){
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          child: Column(
            children: [
              ListTile(
                leading: Container(child: CircleImage("images/img/profil.jpg", 35), width: 40, height: 40,),
                title: Text(forumItems[value].title, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(forumItems[value].resume),
                trailing: IconButton(
                  onPressed: ()=>{
                    setState(() {
                      forumItems[value].isFavorite = !forumItems[value].isFavorite;
                      final snackBar = SnackBar(
                        content: Text(forumItems[value].isFavorite ? 'Poste ajouté aux favoris' : 'Poste retiré des favoris'),
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
                  icon: Icon(Icons.favorite, color: forumItems[value].isFavorite?  Colors.redAccent: Colors.grey,) ,
                ),
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForumSelectedItem(forumItems[value])));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Text('${forumItems[value].replies} réponses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("${formatter.format(forumItems[value].time)}", style: TextStyle(fontSize: 10),),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget forumTopicsAnimated(){
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      initialItemCount: forumItems.length,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) {
        return _buildItem(context, index, animation, forumItems);
      },
    );
  }

  Widget _buildItem(BuildContext context, int value, Animation<double> animation, List<ForumItem> forumItems) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Column(
        children: [
          ListTile(
            leading: Container(child: CircleImage("images/img/profil.jpg", 35), width: 40, height: 40,),
            title: Text(forumItems[value].title, style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(forumItems[value].resume),
            trailing: IconButton(
              onPressed: ()=>{
                setState(() {
                  forumItems[value].isFavorite = !forumItems[value].isFavorite;
                  final snackBar = SnackBar(
                    content: Text(forumItems[value].isFavorite ? 'Poste ajouté aux favoris' : 'Poste retiré des favoris'),
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
              icon: Icon(Icons.favorite, color: forumItems[value].isFavorite?  Colors.redAccent: Colors.grey,) ,
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForumSelectedItem(forumItems[value])));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 70),
                child: Text('${forumItems[value].replies} réponses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text("${formatter.format(forumItems[value].time)}", style: TextStyle(fontSize: 10),),
              )
            ],
          )
        ],
      ),
    );
  }


  _addItem(ForumItem forumItem) {
    _nextItem = forumItems.length;
    setState(() {
      forumItems.add(forumItem);
    });
    _listKey.currentState.insertItem(_nextItem);
  }

  Widget forumFavoritesPost(){
    final favoritePosts = forumItems.where((element) => element.isFavorite).toList();
    return AnimatedList(
      key: _listFavoriteKey,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      initialItemCount: favoritePosts.length,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) {
        return _buildItem(context, index, animation, favoritePosts);
      },
    );
  }

}
