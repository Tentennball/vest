import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:user_vest/global/state.dart';

final Dio dio = Dio();

/// on the ngrok
// const server = "https://14c0-165-229-125-114.jp.ngrok.io";

/// on the test (localhost)
const server = "https://896b-165-229-50-47.ngrok.io";

/// user socket
late IO.Socket socket;

IO.Socket socketInit() {
  socket = IO.io(server, <String, dynamic>{
    'transports': ['websocket'],
  });

  socket.on('connect', (_) {
    socket.on('get-admin-socket', (adminId) {
      adminSocketId = adminId;

      print("listener.dart, socketInit() : $adminSocketId");
    });
    userSocketId = socket.id!;

    print('Socket connected with ID: $userSocketId');

    socket.emit("user-init");
  });

  return socket;
}
