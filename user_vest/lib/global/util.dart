import 'dart:async';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:user_vest/global/state.dart';

final Dio dio = Dio();

/// on the ngrok
// const server = "https://14c0-165-229-125-114.jp.ngrok.io";

/// on the test (localhost)
const server = "http://localhost:8080";

// const server = "https://3328-165-229-50-47.ngrok.io";

Future<void> socketInit() async {
  final Completer<void> completer = Completer<void>();
  socket = IO.io(server, <String, dynamic>{
    'transports': ['websocket'],
  });
  socket.on('connect', (_) {
    userSocketId = socket.id!;
    print('Socket connected with ID: $userSocketId');

    socket.on('get-admin-socket', (adminId) {
      adminSocketId = adminId;
      print("listener.dart, socketInit() : $adminSocketId");
    });

    socket.emit("user-init");
    completer.complete(); // Complete the Future when initialization is done
  });

  return completer.future;
}

/// user socket
late IO.Socket socket;
