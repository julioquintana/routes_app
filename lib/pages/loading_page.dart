import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app2/helpers/helpers.dart';
import 'package:rutas_app2/pages/map_page.dart';

import 'gps_access_page.dart';

class LoadingPage extends StatefulWidget {
  static final route = 'loading';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator().isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navigatorMapFadeIn(context, MapPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: checkGpsAndLocation(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(child: Text(snapshot.data));
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<String> checkGpsAndLocation(BuildContext context) async {
    final permisosGPS = await Permission.location.isGranted;

    final activeGps = await Geolocator().isLocationServiceEnabled();
    if (permisosGPS && activeGps) {
      Navigator.pushReplacement(
          context, navigatorMapFadeIn(context, MapPage()));
      return '';
    } else if (!permisosGPS) {
      Navigator.pushReplacement(
          context, navigatorMapFadeIn(context, GpsAccessPage()));
      return 'Es necesario el permiso del GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
