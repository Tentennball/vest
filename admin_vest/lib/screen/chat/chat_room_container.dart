import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vest/global/state.dart';
import 'package:admin_vest/screen/chat/chat_room.dart';

class ChatRoomContainer extends StatefulWidget {
  const ChatRoomContainer({
    Key? key,
    required this.userSocketId,
  }) : super(key: key);

  final String userSocketId;

  @override
  State<ChatRoomContainer> createState() => _ChatRoomContainerState();
}

class _ChatRoomContainerState extends State<ChatRoomContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isRead = context.watch<ChatManager>().readStatus[widget.userSocketId]!;

    return GestureDetector(
      onTap: () {
        context.read<ChatManager>().checkAsRead(widget.userSocketId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(userSocketId: widget.userSocketId),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isRead ? Colors.blueGrey : Colors.red,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User : ${widget.userSocketId}",
                style: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text(
                context
                        .watch<ChatManager>()
                        .getGlobalChatMap()[widget.userSocketId]!
                        .isEmpty
                    ? " "
                    : context
                        .watch<ChatManager>()
                        .getGlobalChatMap()[widget.userSocketId]!
                        .last
                        .content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
