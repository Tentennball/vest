import 'package:flutter/material.dart';
import 'package:user_vest/global/state.dart';
import 'package:user_vest/screen/auth/login_(deleted).dart';
import 'package:user_vest/screen/chat/chat_room.dart';

void main() {
  runApp(const Vest());
}

class Vest extends StatelessWidget {
  const Vest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        home: isLoggedIn ? const ChatRoom() : const Login()
        //  const Authenticator(),
        );
  }
}
