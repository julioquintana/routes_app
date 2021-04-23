part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.bloc<MapBloc>();
    final locationBloc = context.bloc<MyAddressBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            final goto = locationBloc.state.location;
            mapBloc.moveCam(goto);
          },
        ),
      ),
    );
  }
}
