import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'my_address_event.dart';
part 'my_address_state.dart';

class MyAddressBloc extends Bloc<MyAddressEvent, MyAddressState> {
  MyAddressBloc() : super(MyAddressState());

  final _geolocator = new Geolocator();

  // ignore: cancel_subscriptions
  StreamSubscription<Position> _positionSubscription;

  void cancelTracking() {
    this._positionSubscription?.cancel();
  }

  void startTracking() {
    final geoLocationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionSubscription = this
        ._geolocator
        .getPositionStream(geoLocationOptions)
        .listen((Position position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnChangedLocation(newLocation));
    });
  }

  @override
  Stream<MyAddressState> mapEventToState(MyAddressEvent event) async* {
    if (event is OnChangedLocation) {
      print(event.location);
      yield state.copyWith(existeUbicacion: true, location: event.location);
    }
    //   print('state: ${state.location}');
  }
}
