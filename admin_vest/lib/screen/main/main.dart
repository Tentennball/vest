import 'package:admin_vest/screen/camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_vest/global/state.dart';
import 'package:admin_vest/screen/chat/chat_room_list.dart';
import 'package:admin_vest/screen/map/map.dart';

class Main extends StatefulWidget {
  const Main({
    super.key,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int selectedIdx = 0;

  List<Widget> screens = <Widget>[
    const ChatRoomList(),
    const Map(),
    const Scanner(),
  ];

  void onTapped(int idx) {
    setState(() {
      selectedIdx = idx;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ChatManager>();
    return Scaffold(
      body: Container(
        child: screens.elementAt(selectedIdx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
        ],
        onTap: onTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: selectedIdx,
      ),
    );
  }
}
