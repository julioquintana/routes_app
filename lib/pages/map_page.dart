import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app2/bloc/map/map_bloc.dart';
import 'package:rutas_app2/bloc/my_address/my_address_bloc.dart';
import 'package:rutas_app2/widget/widgets.dart';

class MapPage extends StatefulWidget {
  static final route = 'map';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.bloc<MyAddressBloc>().startTracking();
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MyAddressBloc>().cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyAddressBloc, MyAddressState>(
        builder: (_, state) => buildMap(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnLocation(),
        ],
      ),
    );
  }

  Widget buildMap(MyAddressState state) {
    print(state.existeUbicacion);
    print(state.location);
    if (!state.existeUbicacion) return Center(child: Text('Localizando...'));

    final cameraPosition = CameraPosition(
      target: state.location,
      zoom: 12,
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: context.bloc<MapBloc>().initMap,
    );
  }
}
