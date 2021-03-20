part of 'my_address_bloc.dart';

@immutable
abstract class MyAddressEvent {}

class OnChangedLocation extends MyAddressEvent {
  final LatLng location;
  OnChangedLocation(this.location);
}
