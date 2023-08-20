import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_vest/global/state.dart';
import 'package:user_vest/global/util.dart';
import 'package:user_vest/model/chat_model.dart';
import 'package:user_vest/screen/chat/chat_container.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ScrollController chatScrollController = ScrollController();
  TextEditingController chatDataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenChat();
    scrollToMax();
  }

  @override
  void dispose() {
    chatScrollController.dispose();
    chatDataController.dispose();
    super.dispose();
  }

  void sendChat() {
    if (chatDataController.text.isEmpty) return;

    String createdAt = DateTime.now().toString().substring(0, 19);
    String content = chatDataController.text.trim();

    socket.emit('request-chat', {
      "name": "USER$userSocketId",
      "content": content,
      "createdAt": createdAt,
      "rx": adminSocketId,
      "tx": userSocketId,
      "isAdmin": false,
    });

    setState(() {
      chatList.add(ChatModel(
        name: " USER$userSocketId",
        content: content,
        createdAt: createdAt,
        rx: adminSocketId,
        tx: userSocketId,
        isAdmin: false,
      ));

      /// automatically scroll down
      scrollToMax();
    });
    chatDataController.clear();
  }

  void listenChat() {
    socket.on('response-chat', (data) {
      print("listener.dart linstenChat() $data");
      data = jsonDecode(data);
      setState(() {
        chatList.add(
          ChatModel(
            name: data['name'],
            content: data['content'],
            createdAt: data['createdAt'],
            rx: data['rx'],
            tx: data['tx'],
            isAdmin: data['isAdmin'],
          ),
        );
      });
      scrollToMax();
    });
  }

  void sendSosCall() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Send SOS Call'),
            content: const Text('Are you sure?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  socket.emit("sos", userSocketId);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void scrollToMax() {
    /// automatically scroll down
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chat",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo_album),
            tooltip: 'SOS',
            onPressed: sendSosCall,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              controller: chatScrollController,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                ChatModel chat = chatList[index];
                return ChatContainer(chat: chat);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    child: TextFormField(
                      textInputAction: TextInputAction.go,
                      controller: chatDataController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                      ),
                      onFieldSubmitted: (_) {
                        sendChat();
                      },
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: sendChat,
                icon: const Icon(Icons.send),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
