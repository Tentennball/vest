import 'package:geolocator/geolocator.dart';
import 'package:user_vest/global/util.dart';

void sendLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);

  print(position.latitude);
  print(position.longitude);

  socket.emit("gps", {
    "latitude": position.latitude,
    "longtitude": position.longitude,
  });

  return;
}
