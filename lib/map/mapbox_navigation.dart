import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:latlong/latlong.dart';

class UacNavigation extends StatefulWidget {
  final WayPoint currentLocation;
  final WayPoint targetLocation;
  final MapBoxNavigationMode navigationMode;
  const UacNavigation(this.currentLocation, this.targetLocation, this.navigationMode);
  
  @override
  _UacNavigationState createState() => _UacNavigationState();
}

class _UacNavigationState extends State<UacNavigation> {
  String _platformVersion = 'Unknown';
  String _instruction = "";
  WayPoint _origin ;
  WayPoint _target ;

  MapBoxNavigation _directions;
  MapBoxOptions _options;
  
  bool _isMultipleStop = false;
  double _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  String url =
      "https://api.mapbox.com/styles/v1/evidya/ckddkpbqa473t1in2wu316ngi/wmts?access_token=pk.eyJ1IjoiZXZpZHlhIiwiYSI6ImNrY29uY2NpeTBtdHUycmxodWExZWtkbG0ifQ.ZZAzRAU-f-4FDLGlF4El6w";


  @override
  void initState() {
    super.initState();
    _origin = widget.currentLocation;
    _target = widget.targetLocation;
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
      //initialLatitude: 36.1175275,      
      // initialLongitude: -115.1839524,
      
        zoom: 20.0,
        tilt: 10.0,
        bearing: 5.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: true,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "fr",
        mapStyleUrlDay: url

    );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            MapBoxNavigationView(
                options: _options,
                onRouteEvent: _onEmbeddedRouteEvent,
                onCreated:
                    (MapBoxNavigationViewController controller) async {
                  _controller = controller;
                  controller.initialize();}
            ),
            Positioned(
              child: ElevatedButton(
                child: Text("Start"),
                onPressed: () async {
                  var wayPoints = <WayPoint>[];
                  wayPoints.add(_origin);
                  wayPoints.add(_target);

                  await _directions.startNavigation(
                      wayPoints: wayPoints,
                      options: MapBoxOptions(
                          mode:
                          MapBoxNavigationMode.drivingWithTraffic,
                          simulateRoute: false,
                          language: "fr",
                          units: VoiceUnits.metric));
                },
              ),
            )
          ],
        ),
      ),
    );
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
          await _controller.finishNavigation();
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