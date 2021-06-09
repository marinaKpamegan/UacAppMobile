
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:uac_campus/map/discovery.dart';
import 'package:uac_campus/map/mapbox_navigation.dart';
import 'package:uac_campus/menu.dart';
import 'package:uac_campus/models/uac_locations.dart';
import 'package:location/location.dart';
import 'package:uac_campus/map/search_page.dart';

import 'navigation.dart';


class UacMap extends StatefulWidget {

  final UacLocation selectedLocation;
  final UacLocation targetLocation;
  final bool startNavigation;
  final MapBoxNavigationMode mapBoxNavigationMode;

  const UacMap(this.selectedLocation,{this.targetLocation, this.startNavigation = false, this.mapBoxNavigationMode});


  @override
  MapState createState() {
    return new MapState();
  }
}

// mapbox key and template access
String url = "https://api.mapbox.com/styles/v1/evidya/ckddkpbqa473t1in2wu316ngi/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w";
String key = 'pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w';


class MapState extends State<UacMap> {

  MapController _mapController;
  List<UacLocation> uacPlaces = [];

  Map placesIcon = {
    "Université": "assets/markers/university.png",
    "Transport": "assets/markers/bus.png",
    "Restaurant": "assets/markers/restau.png",
    "StudentSpace": "assets/markers/student.png",
    "Rectorat": "assets/markers/admin.png",
    "Aid": "assets/markers/aid.png",
    "Library": "assets/markers/book.png",
    "User": "assets/markers/location.png",
  };

  bool _isVisible = false;
  var location = Location();
  bool enabled = false;

  // end navigation

  // markers
  var markers = <Marker>[];
  GlobalKey _globalKey = GlobalKey();
  LatLng result = new LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      enabled = await location.serviceEnabled();
      result = await acquireCurrentLocation();
      initializeList();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // map
            SafeArea(
              child:  MapboxMap(
                accessToken: key,
               // styleString: url,
                initialCameraPosition: CameraPosition(
                  zoom: 15.0,
                  target: LatLng(14.508, 46.048),
                ),
                onMapCreated: (MapboxMapController controller) async {
                  await controller.animateCamera(
                    CameraUpdate.newLatLng(new LatLng(widget.selectedLocation.lat, widget.selectedLocation.lng)),
                  );
                },
              ),
            ),
            // end map

            Container(
              height: 50,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2, // changes position of shadow
                  ),
                ],

              ),
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Rechercher",
                      prefixIcon: Icon(
                        Icons.search, color: Colors.black26, size: 24,)
                  ),
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(uacPlaces),
                      ),
                    );
                  }
              ),
            ),
            //gps location or start navigation

            Positioned(
                top: 90,
                right: 8,
                child: Visibility(
                  visible: _isVisible,
                  replacement: FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.white,
                    onPressed: () {

                    },
                    child: enabled ? Icon(
                      Icons.gps_fixed,
                      color: Color.fromRGBO(3, 80, 146, 1),
                      size: 28,
                    ) : Icon(
                      Icons.gps_off,
                      color: Colors.redAccent,
                      size: 28,
                    ),
                  ),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.navigation, color: Colors.white,),
                          Text("Start", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      onPressed: () async {
                        /* await _directions.startNavigation(
                        origin: _origin,
                        destination: _destination,
                        mode: widget.mapBoxNavigationMode,
                        simulateRoute: true,
                        language: "fr",
                        units: VoiceUnits.metric
                    );*/
                        print("navigation finished");
                      }
                  ),
                )
            ),

            // navigation (select the target place)
            Positioned(
              bottom: 280,
              left: 8,
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Color.fromRGBO(35, 154, 105, 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Navigation(uacPlaces),
                    ),
                  );
                },
                child: Text(
                  "Go", style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
            ),


            // bottom sheet

            /* Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Visibility(
                visible: _isVisible ? false : true,
                child: CustomBottomSheet(),
                replacement: Container(),
              ),
            )*/
            // Home
            Positioned(
              bottom: 200,
              left: 8,
              child: FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Menu(),
                    ),
                  );
                },
                child: Icon(
                  Icons.home, color: Color.fromRGBO(35, 154, 105, 1),),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.05,
              maxChildSize: 0.8,
              builder: (BuildContext context, myscrollController) {
                return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(35, 154, 105, 1),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30)),
                    ),
                    child: Discovery(myscrollController)
                );
              },
            )


            // CustomBottomSheet(),
          ],
        ),
      ),

    );
  }

  // uac places get from json file
  initializeList() {
    WidgetsFlutterBinding.ensureInitialized();

    String file = 'assets/uac_places.json';
    readFileAsync(file);
  }

  Future<dynamic> readFileAsync(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);

    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    List<UacLocation> uacLocation = parsed.map<UacLocation>((
        json) => new UacLocation.fromJson(json)).toList();

    uacPlaces = uacLocation;

    // markers initialisation

    if (uacPlaces.length > 0) {
      // print(uacPlaces.length);
      for (int i = 0; i <= uacPlaces.length - 1; i++) {
        markers.add(Marker(
          // FIXME: Don't forget to fix this
            // point: LatLng(uacPlaces[i].lat, uacPlaces[i].lng),
            builder: (ctx) =>
                InkWell(
                  child: Container(
                      child: Image.asset(
                        placesIcon[uacPlaces[i].type], width: 150, height: 192,)
                  ),
                  onTap: () {
                    print(uacPlaces[i].description);
                  },
                )
        ));
        // print(uacPlaces[i].description);
      }
    }

    // end

    // print(_uacLocation[2].name);
    return 1;
  }
  Future<LatLng> acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    Location location = new Location();

    // Whether or not the location service is enabled
    bool serviceEnabled;

    // Status of a permission request to use location services
    PermissionStatus permissionGranted;

    // Check if the location service is enabled, and if not, then request it. In
    // case the user refuses to do it, return immediately with a null result
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check for location permissions; similar to the workflow in Android apps,
    // so check whether the permissions is granted, if not, first you need to
    // request it, and then read the result of the request, and only proceed if
    // the permission was granted by the user
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Gets the current location of the user
    final locationData = await location.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }
}
