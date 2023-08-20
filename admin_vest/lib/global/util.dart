import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:admin_vest/global/state.dart';

final Dio dio = Dio();

/// on the ngrok
// const server = "https://14c0-165-229-125-114.jp.ngrok.io";

/// on the test (localhost)
const server = "http://localhost:8080/";

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

late IO.Socket socket;
