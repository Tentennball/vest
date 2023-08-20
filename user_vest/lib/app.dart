import 'package:flutter/material.dart';
import 'package:user_vest/global/state.dart';
import 'package:user_vest/global/util.dart';
import 'package:user_vest/screen/auth/authenticator.dart';
import 'package:user_vest/screen/chat/chat_room.dart';

void main() {
  runApp(const Vest());
}

class Vest extends StatefulWidget {
  const Vest({super.key});

  @override
  State<Vest> createState() => _VestState();
}

class _VestState extends State<Vest> {
  @override
  void initState() {
    super.initState();
    socket = socketInit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const ChatRoom() : const Authenticator()
        //  const Authenticator(),
        );
  }
}
