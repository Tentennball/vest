import 'package:flutter/material.dart';
import 'package:admin_vest/global/listener.dart';
import 'package:admin_vest/global/state.dart';
import 'package:admin_vest/screen/main/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatManager(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Vest(),
      ),
    ),
  );
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
    listenChat(context);
    listenRoomId(context);
    listenSosCall(context);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}
