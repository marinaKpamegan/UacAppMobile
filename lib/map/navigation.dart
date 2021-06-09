
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:uac_campus/map/map.dart';
import 'package:uac_campus/map/search_page.dart';
import 'package:uac_campus/models/uac_locations.dart';
import 'package:location/location.dart';

import 'mapbox_navigation.dart';

class Navigation extends StatefulWidget{

  const Navigation(this.placeList);
  final List<UacLocation> placeList;

  @override
  State<StatefulWidget> createState()=>NavigationState();
}

class NavigationState extends State<Navigation> {
  TextEditingController controller = new TextEditingController();
  String filter;
  UacLocation targetLocation;
  UacLocation userLocation;
  bool _isVisible = false;
  bool _isCarActive = true;
  bool _isWalkActive = false;
  bool _isBikeActive = false;
  MapBoxNavigationMode _mapBoxNavigationMode = MapBoxNavigationMode.drivingWithTraffic;

  // Mapping

  static Color gray = Colors.black26;
  Map locationCatToIcon = {
    "Université": Icon(Icons.school, color: gray,),
    "Transport": Icon(Icons.directions_bus, color: gray,),
    "Restaurant": Icon(Icons.restaurant, color: gray,),
    "Library": Icon(Icons.import_contacts, color: gray,),
    "StudentSpace": Icon(Icons.hotel, color: gray),
    "Rectorat": Icon(Icons.business, color: gray,),
  };

  // end mapping

  //---- location services -----

  bool _permission = false;

  String _serviceError = '';
  final Location _locationService = Location();
  LocationData _currentLocation;


  //----- end location services ----

  @override
  void initState(){
    super.initState();
    controller.addListener(() {
      setState(() {
        if (widget.placeList == null){
          print("its null");
        }
        filter = controller.text;
      });
    });
    initLocationService();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black54,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        focusedBorder: InputBorder.none,
                        hintText: "De votre position à",
                        border: InputBorder.none
                    ),
                    readOnly: true,
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10),
                  height: 15,
                  child: Icon(Icons.my_location, color: Colors.redAccent, size: 20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 30, left: 25),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        focusedBorder: InputBorder.none,
                        hintText: "Choisir point d'arrivé",
                        border: InputBorder.none
                    ),

                    controller: controller,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(left: 10),
                  height: 15,
                  child: Icon(Icons.location_on, color: Colors.blueAccent, size: 20),
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(left: 40),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: _isCarActive? Icon(Icons.directions_car, color: Colors.lightBlue, size: 20): Icon(Icons.directions_car, color: Colors.black, size: 20),
                    decoration: _isCarActive? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Color.fromRGBO(204, 224, 255, 1).withOpacity(0.6),
                    ): null,
                  ),
                  onTap: (){
                    setState(() {
                      _isCarActive = true;
                      _isBikeActive = false;
                      _isWalkActive = false;
                      _mapBoxNavigationMode = MapBoxNavigationMode.driving;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: _isBikeActive? Icon(Icons.motorcycle, color: Colors.blueAccent, size: 20): Icon(Icons.motorcycle, color: Colors.black, size: 20),
                    decoration: _isBikeActive? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Color.fromRGBO(204, 224, 255, 1).withOpacity(0.6),
                    ): null,
                  ),
                  onTap: (){
                    setState(() {
                      _isCarActive = false;
                      _isBikeActive = true;
                      _isWalkActive = false;
                      _mapBoxNavigationMode = MapBoxNavigationMode.cycling;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: 40),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: _isWalkActive? Icon(Icons.directions_walk, color: Colors.indigoAccent, size: 20):Icon(Icons.directions_walk, color: Colors.black, size: 20),
                    decoration: _isWalkActive? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Color.fromRGBO(204, 224, 255, 1).withOpacity(0.6),
                    ): null,
                  ),
                  onTap: (){
                    setState(() {
                      _isCarActive = false;
                      _isBikeActive = false;
                      _isWalkActive = true;
                      _mapBoxNavigationMode = MapBoxNavigationMode.walking;
                    });
                  },
                )
              ],
            ),

            Container(
              color: Colors.grey.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              height: 2,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.placeList.length,
                itemBuilder: (BuildContext context, int index){
                  return filter == null || filter == "" ?
                  ListTile(
                      title: Text(widget.placeList[index].name),
                      leading: locationCatToIcon[widget.placeList[index].type],
                      subtitle: Text(widget.placeList[index].description),
                      onTap: () => {
                        controller.text = widget.placeList[index].name,
                        targetLocation = widget.placeList[index],
                        _isVisible = true
                      }
                  ):
                  widget.placeList[index].name.contains(filter.capitalize()) ?
                  ListTile(
                      title: Text(widget.placeList[index].name),
                      leading: locationCatToIcon[widget.placeList[index].type],
                      subtitle: Text(widget.placeList[index].description),
                      onTap: () => {
                        controller.text = widget.placeList[index].name,
                        targetLocation = widget.placeList[index],
                        _isVisible = true,
                      }
                  ): Container();
                },

              ),
            ),

          ],
        ),
      ),

      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          child: Icon(
            Icons.done,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
          onPressed: (){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => userLocation != null ?  UacNavigation(WayPoint(name: "User Location", longitude: userLocation.lng, latitude: userLocation.lat), WayPoint(name: "User Location", longitude: targetLocation.lng, latitude: targetLocation.lat), _mapBoxNavigationMode) /* UacMap(userLocation, targetLocation: targetLocation, startNavigation: true, mapBoxNavigationMode: _mapBoxNavigationMode,) */: null
                )
            );
          },
        ),
      ),
    );
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService
              .onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;
                userLocation = UacLocation("", "Votre position", _currentLocation.latitude, _currentLocation.longitude, "User");
                // If Live Update is enabled, move map center
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

}







