part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapDone;

  MapState({
    this.mapDone = false,
  });

  MapState copyWith({bool mapDone}) =>
      MapState(mapDone: mapDone ?? this.mapDone);
}
