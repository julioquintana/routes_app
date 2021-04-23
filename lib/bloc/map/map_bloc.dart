import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app2/util/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.mapDone) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uber_map_theme));
      add(OnMapDone());
    }
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapDone) {
      print('map Done');
      yield state.copyWith(mapDone: true);
    }
  }

  void moveCam(LatLng _goto) {
    final camUpdated = CameraUpdate.newLatLng(_goto);
    this._mapController?.animateCamera(camUpdated);
  }
}
