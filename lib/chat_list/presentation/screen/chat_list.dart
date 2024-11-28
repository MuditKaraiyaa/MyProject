import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:xbridge/chat_list/presentation/widget/chat_list_state.dart';
import 'package:xbridge/common/constants/route_constants.dart';

class ChatListState extends State<ChatList> {
  final List<types.User> chatUsers = generateUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatUsers.length,
        itemBuilder: (context, index) {
          final user = chatUsers[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_640.png",
              ),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text('UserID: ${user.id}'),
            onTap: () {
               GoRouter.of(context).pushNamed(
                RouteConstants.chatPage,
              
              );
            },
          );
        },
      ),
    );
  }
}
