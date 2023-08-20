import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vest/global/state.dart';
import 'package:vest/global/util.dart';
import 'package:vest/model/chat_model.dart';
import 'package:vest/screen/chat/chat_container.dart';

class ChatRoom extends StatefulWidget {
  final String userSocketId;
  const ChatRoom({
    Key? key,
    required this.userSocketId,
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
    autoScroll();

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
  void dispose() {
    socket.off("scroll-event");
    chatScrollController.dispose();
    chatDataController.dispose();
    super.dispose();
  }

  void sendChat() {
    if (chatDataController.text.isEmpty) return;

    String createdAt = DateTime.now().toString().substring(0, 19);
    String content = chatDataController.text.trim();
    socket.emit('request-chat', {
      "name": "ADMIN$adminSocketId",
      "content": content,
      "createdAt": createdAt,
      "rx": widget.userSocketId,
      "tx": adminSocketId,
      "isAdmin": true,
    });
    context.read<ChatManager>().sendChat(
        widget.userSocketId,
        ChatModel(
          name: " ADMIN$adminSocketId",
          content: content,
          createdAt: createdAt,
          rx: widget.userSocketId,
          tx: adminSocketId,
          isRead: false,
        ));

    setState(() {
      /// automatically scroll down
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
    chatDataController.clear();
  }

  void autoScroll() {
    socket.on(
        "scroll-event",
        (_) => {
              /// automatically scroll down
              WidgetsBinding.instance.addPostFrameCallback((_) {
                chatScrollController.animateTo(
                  chatScrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ChatManager>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User : ${widget.userSocketId}",
          // " ${globalChatMap[widget.userSocketId]!.elementAt(0).name}",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              controller: chatScrollController,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemCount: context
                  .watch<ChatManager>()
                  .getGlobalChatMap()[widget.userSocketId]!
                  .length,
              itemBuilder: (context, index) {
                ChatModel chat = context
                    .watch<ChatManager>()
                    .getGlobalChatMap()[widget.userSocketId]![index];
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
