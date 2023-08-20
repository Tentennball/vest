import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:vest/global/state.dart';
import 'package:vest/model/chat_model.dart';

class ChatContainer extends StatelessWidget {
  final ChatModel chat;

  const ChatContainer({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(
        type: adminSocketId == chat.tx
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      alignment: adminSocketId == chat.tx
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor:
          adminSocketId == chat.tx ? Colors.blue : const Color(0xffE7E7ED),
      child: Container(
        padding: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.content,
              style: adminSocketId == chat.tx
                  ? const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )
                  : const TextStyle(
                      fontSize: 20,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              chat.createdAt,
              style: TextStyle(
                fontSize: 10,
                color: adminSocketId == chat.tx ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
