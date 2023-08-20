import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vest/global/state.dart';
import 'package:admin_vest/global/util.dart';
import 'package:admin_vest/model/chat_model.dart';

void listenChat(BuildContext context) {
  socket.on('response-chat', (data) {
    print("listener.dart linstenChat() $data");
    data = jsonDecode(data);
    context.read<ChatManager>().sendChat(
          data['tx'],
          ChatModel(
            name: data['name'],
            content: data['content'],
            createdAt: data['createdAt'],
            rx: data['rx'],
            tx: data['tx'],
            isRead: false,
          ),
        );
    context.read<ChatManager>().checkAsUnread(data['tx']);
  });
}

void listenRoomId(BuildContext context) {
  socket.on(
    "admin-get-roomid",
    (userSocketId) => {
      print("listener.dart , linstenRoomId() $userSocketId"),
      context.read<ChatManager>().initChatRoom(userSocketId),
    },
  );
}

void listenSosCall(BuildContext context) {
  socket.on(
    "admin-get-sos",
    (userSocketId) {
      print("listener.dart , listenSosCall() $userSocketId");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'SOS CALL',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: Row(
              children: [
                const Text(
                  "User",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  " $userSocketId ",
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "sended ",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                const Text(
                  "SOS Call",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    },
  );
}
