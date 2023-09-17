import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:user_vest/global/state.dart';
import 'package:user_vest/global/util.dart';
import 'package:user_vest/screen/chat/chat_room.dart';

class Authenticator extends StatefulWidget {
  const Authenticator({super.key});

  @override
  State<Authenticator> createState() => _AuthenticatorState();
}

class _AuthenticatorState extends State<Authenticator> {
  Future<void>?
      socketInitialization; // Use Future to handle async initialization

  @override
  void initState() {
    super.initState();
    socketInitialization = socketInit(); // Start socket initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: socketInitialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return QrImageView(
                data: '$server/ticket-check?userSocketId=$userSocketId',
                version: QrVersions.auto,
                size: 320,
                gapless: false,
              );
            }
          },
        ),
      ),
    );
  }
}
