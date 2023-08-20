import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vest/model/chat_model.dart';

/// this could be gotton by login
late String adminSocketId;

/// Global chat list
///
/// Key : User ID
///
/// Value : Chat list with each user
class ChatManager with ChangeNotifier {
  HashMap<String, List<ChatModel>> globalChatMap = HashMap();
  HashMap<String, bool> readStatus = HashMap();

  void initChatRoom(String userSocketId) {
    globalChatMap
        .addEntries([MapEntry<String, List<ChatModel>>(userSocketId, [])]);
    readStatus.addEntries([MapEntry<String, bool>(userSocketId, false)]);
    notifyListeners();
  }

  void sendChat(String userSocketId, ChatModel newChat) {
    globalChatMap[userSocketId]!.add(newChat);
    notifyListeners();
  }

  HashMap<String, List<ChatModel>> getGlobalChatMap() {
    return globalChatMap;
  }

  void checkAsRead(String userSocketId) {
    readStatus[userSocketId] = true;
    notifyListeners();
  }

  void checkAsUnread(String userSocketId) {
    readStatus[userSocketId] = false;
    notifyListeners();
  }
}
