
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:uac_campus/map/discovery.dart';
import 'package:uac_campus/menu.dart';
import 'package:uac_campus/models/uac_locations.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:uac_campus/map/search_page.dart';


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
bool _isMultipleStop = false;
double _distanceRemaining, _durationRemaining;
MapBoxNavigationViewController _mapController;
bool _routeBuilt = false;
bool _isNavigating = false;

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

  // Navigation and location

  String _platformVersion = 'Unknown';
  String _instruction = "";
  WayPoint _origin;

  WayPoint _destination;

  MapBoxNavigation _directions;
  MapBoxOptions _options;

  bool _arrived = false;
  double _distanceRemaining, _durationRemaining;
  bool _isVisible = false;
  var location = Location();
  bool enabled = false;

  // end navigation

  // markers
  var markers = <Marker>[];
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      enabled = await location.serviceEnabled();
      initializeList();
      initialize();
    });
    if (widget.startNavigation == true) {
      _origin = WayPoint(name: widget.selectedLocation.name,
          latitude: widget.selectedLocation.lat,
          longitude: widget.selectedLocation.lng);
      _destination = WayPoint(name: widget.targetLocation.name,
          latitude: widget.targetLocation.lat,
          longitude: widget.targetLocation.lng);
      _isVisible = true;
      markers.add(
          new Marker(
              point: LatLng(
                  widget.selectedLocation.lat, widget.selectedLocation.lng),
              builder: (ctx) =>
                  InkWell(
                    child: Container(
                        child: Image.asset(
                          placesIcon[widget.selectedLocation.type], width: 150,
                          height: 192,)
                    ),
                    onTap: () {
                      print(widget.selectedLocation.description);
                      setState(() {

                      });
                    },
                  )
          )
      );
    }
    _mapController = MapController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // map
            SafeArea(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(
                      widget.selectedLocation.lat, widget.selectedLocation.lng),
                  minZoom: 10,
                  maxZoom: 18.5,
                  zoom: 18.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: url,
                    additionalOptions: {
                      'accessToken': 'pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w',
                      'id': 'mapbox.mapbox-streets-v7',
                    },

                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),

                ],
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
                      builder: (context) => null, //Navigation(uacPlaces),
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
            point: LatLng(uacPlaces[i].lat, uacPlaces[i].lng),
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

  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
      //initialLatitude: 36.1175275,
      //initialLongitude: -115.1839524,
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          // await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }

}
