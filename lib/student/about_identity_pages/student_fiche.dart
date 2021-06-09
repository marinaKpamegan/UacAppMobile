import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:uac_campus/student/about_identity_pages/student_identity.dart';
import 'package:uac_campus/utils/color_palette.dart';
import 'package:uac_campus/utils/list_item.dart';
import 'package:uac_campus/widgets/bottom_navigation_bar.dart';
import 'package:uac_campus/widgets/custom_app_bar.dart';
import 'package:uac_campus/widgets/drawer.dart';
import 'package:path/path.dart';
import '../about_validation_pages/student_validation.dart';


class StudentFiche extends StatefulWidget{
  @override
  _StudentFicheState createState() => _StudentFicheState();
}

class _StudentFicheState extends State<StudentFiche> {
  final Color globalColor = Color.fromRGBO(255, 255, 255, 1.0);
  final Color inactiveColor = Color.fromRGBO(231, 231, 231, 1.0);
  TextEditingController fnController = TextEditingController()..text = 'KPAMEGAN';
  TextEditingController lnController = TextEditingController()..text = 'Falonne Marina';
  Color containerbackgrnd = Color.fromRGBO(238, 238, 238, 1);

  List<ListItem> _civiliteItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Rd Père")
  ];
  List<ListItem> _sexeItems = [ListItem(0, "femme"), ListItem(0, "homme")];
  List<DropdownMenuItem<ListItem>> _civiliteMenuItems;
  List<DropdownMenuItem<ListItem>> _sexeMenuItems;
  ListItem _civiliteSelectedItem;
  ListItem _sexe;
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _civiliteMenuItems = buildDropDownMenuItems(_civiliteItems);
    _civiliteSelectedItem = _civiliteMenuItems[0].value;
    _sexeMenuItems = buildDropDownMenuItems(_sexeItems);
    _sexe = _sexeMenuItems[0].value;
  }


  Widget build(BuildContext context) {
    String iconPath = "assets/images/icons";
    final Color globalColor = Color.fromRGBO(9, 113, 52, 1);
    List<Widget> tabs = [
      Tab(
        text: "Identité"
      ),
      Tab(
        text: "Proches",
      ),
      Tab(
          text: "Contacts"
      ),
      Tab(
          text: "Validations"
      )
    ];

    List<Widget> pages = [
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Civilité:", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ListItem>(
                        value: _civiliteSelectedItem,
                        items: _civiliteMenuItems,
                        onChanged: (value){
                          setState(() {
                            _civiliteSelectedItem = value;
                          });
                        },

                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Nom:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: fnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Prénoms:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Sexe:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _sexe,
                        items: _sexeMenuItems,
                        onChanged: (value){
                          setState(() {
                            _sexe = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Catégorie de Candidat:", style: TextStyle(fontWeight: FontWeight.bold), softWrap: true,),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 120,
                    child: Text("Date de Naissance:", style: TextStyle(fontWeight: FontWeight.bold), softWrap: true,),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text("Civilité:", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ListItem>(
                        value: _civiliteSelectedItem,
                        items: _civiliteMenuItems,
                        onChanged: (value){
                          setState(() {
                            _civiliteSelectedItem = value;
                          });
                        },

                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text("Nom:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: fnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text("Prénoms:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: lnController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text("Sexe:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    color: containerbackgrnd,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    margin: EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width - 150,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _sexe,
                        items: _sexeMenuItems,
                        onChanged: (value){
                          setState(() {
                            _sexe = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.green,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context, "Ma Fiche"),
      body: SafeArea(
        child: DefaultTabController(
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
                      pages.elementAt(3),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(context, "/fiche"),
      bottomNavigationBar: BottomNavigationBarWidget(context, 1),
    );
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}


