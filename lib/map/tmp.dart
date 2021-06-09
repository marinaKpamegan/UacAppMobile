
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String style = "https://api.mapbox.com/styles/v1/evidya/ckddkpbqa473t1in2wu316ngi/wmts?access_token=pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w";
    final String token = 'pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w';


    return Scaffold(
      body: MapboxMap(
        accessToken: token,
        styleString: style,
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: LatLng(14.508, 46.048),
        ),
        onMapCreated: (MapboxMapController controller) async {
          final result = await acquireCurrentLocation();
          await controller.animateCamera(
            CameraUpdate.newLatLng(result),
          );

          await controller.addCircle(
            CircleOptions(
              circleRadius: 8.0,
              circleColor: '#006992',
              circleOpacity: 0.8,
              geometry: result,
              draggable: false,
            ),
          );
        },

        // I'm using the onMapLongClick callback here, but there's also one for
        // a single tap, onMapClick, but heck, that's just for a tutorial
       /* onMapLongClick: (Point<double> point, LatLng coordinates) async {
          // Add a symbol (marker)
          await _mapController.addSymbol(
            SymbolOptions(
              // You retrieve this value from the Mapbox Studio
              iconImage: 'embassy-15',
              iconColor: '#006992',

              // YES, YOU STILL NEED TO PROVIDE A VALUE HERE!!!
              geometry: coordinates,
            ),
          );
        },*/
      ),
    );
  }
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