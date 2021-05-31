import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uac_campus/map/map.dart';
import 'package:uac_campus/models/uac_locations.dart';

class SearchPage extends StatefulWidget{

  const SearchPage(this.placeList);
  final List<UacLocation> placeList;

  @override
  State<StatefulWidget> createState()=>SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController controller1 = new TextEditingController();
  String filter;

  @override
  void initState(){
    super.initState();

    controller1.addListener(() {
      setState(() {
        filter = controller1.text;
      });
    });
  }
  @override
  void dispose() {
    controller1.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              height: 45,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2, // changes position of shadow
                  ),
                ],
                ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Rechercher un lieu",
                    prefixIcon: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black54,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                ),
                controller: controller1,
              ),
            ),

            Container(
              color: Colors.grey.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              height: 2,
            ),

            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: widget.placeList.length,
                itemBuilder: (BuildContext context, int index){
                  return filter == null || filter == ""?
                  ListTile(
                      title: Text(widget.placeList[index].name),
                      leading: locationCatToIcon[widget.placeList[index].type],
                      subtitle: Text(widget.placeList[index].description),
                      onTap: () => {
                        getItemAndNavigate(widget.placeList[index], context)
                      }
                  ):
                  widget.placeList[index].name.contains(filter.capitalize()) ?
                  ListTile(
                      title: Text(widget.placeList[index].name),
                      leading: locationCatToIcon[widget.placeList[index].type],
                      subtitle: Text(widget.placeList[index].description),
                      onTap: () => {
                        getItemAndNavigate(widget.placeList[index], context)
                      }
                  ):
                  new Container();
                },
                separatorBuilder: (BuildContext context, int index){
                  return Divider(height: 20,);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  static Color gray = Colors.black26;
  Map locationCatToIcon = {
    "Université": Icon(Icons.school, color: Colors.blueAccent,),
    "Transport": Icon(Icons.directions_bus, color: Colors.yellow,),
    "Restaurant": Icon(Icons.restaurant, color: Colors.green,),
    "Library": Icon(Icons.import_contacts, color: Colors.blueGrey,),
    "StudentSpace": Icon(Icons.hotel, color: Colors.red),
    "Rectorat": Icon(Icons.business, color: Colors.black12,),
  };

  void getItemAndNavigate(UacLocation selectedLocation, BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => /*UacMap(selectedLocation)*/ null
        )
    );
  }

  List<UacLocation> getList(){
    return widget.placeList;
  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}



