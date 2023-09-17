import 'dart:async';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:user_vest/global/state.dart';

final Dio dio = Dio();

/// on the ngrok
// const server = "https://whole-physically-sloth.ngrok-free.app";

// on the local tunnel
// const server = "https://free-frogs-search.loca.lt";

/// on the test (localhost)
const server = "http://localhost:9000";

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
    completer.complete();
  });

  return completer.future;
}

/// user socket
late IO.Socket socket;
