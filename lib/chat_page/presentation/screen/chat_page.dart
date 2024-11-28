// import 'package:flutter/material.dart';
// import 'package:xbridge/chat_page/presentation/widget/chat_page_state.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key, required this.arguments});

//   final ChatPageArguments arguments;

//   @override
//   ChatPageState createState() => ChatPageState();
// }

// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/custom_network_exception.dart';
import 'package:xbridge/common/network/response_handler.dart';
import 'package:xbridge/common/service/database_service.dart';
import 'package:xbridge/common/widgets/message_tile.dart';

import '../../../common/theme/styles.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  final List<String> deviceToken;
  const ChatPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
    required this.deviceToken,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  ResponseHandler handler = ResponseHandler();
  late final RetryClient client;

  @override
  void initState() {
    currentActiveChatGroupId = widget.groupId;
    getChatandAdmin();
    client = RetryClient(
      http.Client(),
      retries: 1,
      when: (response) {
        return response.statusCode == 401;
      },
    );

    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.groupName,
          style: Styles.textStyledarkWhite20dpRegular,
        ),
        backgroundColor: AppColors.primaryButtonBackgroundColor,
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[800],
              ),
              padding: EdgeInsets.only(left: 12.w, top: 3, bottom: 3),
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryButtonBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(bottom: 100.h),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  int itemCount = snapshot.data.docs.length ?? 0;
                  int reversedIndex = itemCount - 1 - index;

                  return MessageTile(
                    message: snapshot.data.docs[reversedIndex]['message'],
                    sender: snapshot.data.docs[reversedIndex]['sender'],
                    sentByMe: widget.userName == snapshot.data.docs[reversedIndex]['sender'],
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      // DatabaseService().sendPushNotification([
      //   'ePutK0UARhm0sktRpfrjdD:APA91bEpiC2V3HgE32ETto2Lx54LnpJdKIXjyyUx_Sv0-AtPY0rWLmiEQqXGvh0sKe4RxixmDg0_Ugqyjd112Wr1PiXOzmQENUL7q_3m8rAePI9CoBNJdi8yculbWMF9FbsfcRjF9-ck'
      // ], "got message");

      for (var element in widget.deviceToken) {
        if (userDeviceToken != element) {
          var jsonData = {
            "to": element,
            "notification": {
              "body": "you have a new message",
              "title": "New Message",
              "subtitle": "you have a new message",
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "otherData": {
                "screen": "chat",
                "groupId": widget.groupId,
                "groupName": widget.groupName,
                // "userName": widget.userName,
                "deviceToken": widget.deviceToken,
              },
            },
          };
          String jsonBody = json.encode(jsonData);
          postPushNotificationMethod(jsonBody);
        }
      }

      setState(() {
        messageController.clear();
      });
    }
  }

  Future<dynamic> postPushNotificationMethod(String body) async {
    var responseJson;
    try {
      final response = await client.post(
        Uri.parse(APIConstant.sendPushNotification),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization':
              'key=AAAAXhSNumk:APA91bHIsFbQMAdP0gAsv2_AEck_-v7aF3pd3252cm42wHBEfhfEGDEExhnT8kUhm60ZF3TvAKQN4elBeyQVhgYIUPO4GZ7j3mFvQwnGZXd75jYsD8j-qbuBCtO83iR09Alj7hGFYxp5',
        },
        body: body,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw Exception(
        "The request couldn't be processed. Please try again.",
      );
    }
    return responseJson;
  }
}
