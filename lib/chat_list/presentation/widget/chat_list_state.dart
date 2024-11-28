import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:xbridge/chat_list/presentation/screen/chat_list.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => ChatListState();
}

List<types.User> generateUsers() {
  List<types.User> users = [];

  for (int i = 1; i <= 10; i++) {
    var user = types.User(
      id: 'user_$i',
      firstName: 'User',
      lastName: '$i',
    );
    users.add(user);
  }

  return users;
}

