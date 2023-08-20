import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vest/global/state.dart';
import 'package:vest/screen/chat/chat_room_container.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  ScrollController chatListController = ScrollController();

  @override
  void initState() {
    super.initState();

    /// automatically scroll down
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatListController.animateTo(
        chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ChatManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              controller: chatListController,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // itemCount: globalChatMap.keys.toList().length,
              itemCount:
                  context.read<ChatManager>().getGlobalChatMap().keys.length,
              itemBuilder: (context, index) {
                return ChatRoomContainer(
                  userSocketId: context
                      .read<ChatManager>()
                      .getGlobalChatMap()
                      .keys
                      .toList()[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
