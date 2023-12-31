import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:admin_vest/global/state.dart';

final Dio dio = Dio();

/// on the ngrok
// const server = "https://whole-physically-sloth.ngrok-free.app";
// const server = "https://free-frogs-search.loca.lt";
// const server = "https://rooster-master-mayfly.ngrok-free.app";

/// on the test (localhost)
const server = "http://localhost:9000";

IO.Socket socketInit() {
  socket = IO.io(server, <String, dynamic>{
    'transports': ['websocket'],
  });

  socket.on('connect', (_) {
    adminSocketId = socket.id!;

    print('Socket connected with ID: $adminSocketId');

    socket.emit("admin-init");
  });

  return socket;
}

IO.Socket socket = socketInit();
