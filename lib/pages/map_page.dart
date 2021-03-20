import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app2/bloc/my_address/my_address_bloc.dart';

class MapPage extends StatefulWidget {
  static final route = 'map';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _myAddressBloc = MyAddressBloc();

  @override
  void initState() {
    _myAddressBloc.startTracking();
    super.initState();
  }

  @override
  void dispose() {
    _myAddressBloc.cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyAddressBloc, MyAddressState>(
        cubit: _myAddressBloc,
        builder: (context, state) => buildMap(state),
      ),
    );
  }

  Widget buildMap(MyAddressState state) {
    if (!state.existeUbicacion) return Center(child: Text('Localizando...'));

    return Center(
      child: Text(
          '${state.existeUbicacion},${state.location?.latitude}, ${state.location?.longitude}'),
    );
  }
}
