import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app2/pages/loading_page.dart';

class GpsAccessPage extends StatefulWidget {
  static final route = 'gps_access';

  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage>
    with WidgetsBindingObserver {
  bool popup = false;

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
    if (state == AppLifecycleState.paused && !popup) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, LoadingPage.route);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Es necesario el GPS para usar esta app'),
          MaterialButton(
            child:
                Text('Solicitar Acceso', style: TextStyle(color: Colors.white)),
            color: Colors.black87,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () async {
              popup = true;
              final status = await Permission.location.request();
              await gpsAccess(status);
              popup = false;
            },
          ),
        ],
      ),
    ));
  }

  Future gpsAccess(PermissionStatus status) async {
    print(status);
    switch (status) {
      //case PermissionStatus.undetermined:
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, LoadingPage.route);
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
