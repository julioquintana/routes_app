import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app2/bloc/my_address/my_address_bloc.dart';
import 'package:rutas_app2/pages/gps_access_page.dart';
import 'package:rutas_app2/pages/loading_page.dart';
import 'package:rutas_app2/pages/map_page.dart';

import 'bloc/map/map_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyAddressBloc()),
        BlocProvider(create: (_) => MapBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          MapPage.route: (_) => MapPage(),
          GpsAccessPage.route: (_) => GpsAccessPage(),
          LoadingPage.route: (_) => LoadingPage(),
        },
      ),
    );
  }
}
