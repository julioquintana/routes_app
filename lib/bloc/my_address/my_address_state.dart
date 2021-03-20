part of 'my_address_bloc.dart';

@immutable
class MyAddressState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng location;

  MyAddressState({
    this.siguiendo = true,
    this.existeUbicacion = false,
    this.location,
  });
  MyAddressState copyWith({
    final bool siguiendo,
    final bool existeUbicacion,
    final LatLng location,
  }) =>
      MyAddressState(
          siguiendo: siguiendo ?? this.siguiendo,
          existeUbicacion: existeUbicacion ?? this.existeUbicacion,
          location: location ?? this.location);
}
