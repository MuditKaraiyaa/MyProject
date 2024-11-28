import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xbridge/chat_page/presentation/screen/chat_page.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/util.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final List<String> deviceToken;

  const GroupTile({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
    required this.deviceToken,
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the dialog

        receiverMsgId = widget.groupId;
        // GoRouter.of(context).pushNamed(
        //   RouteConstants.chatPage,
        // );

        nextScreen(
          context,
          ChatPage(
            groupId: widget.groupId,
            groupName: widget.groupName,
            userName: widget.userName,
            deviceToken: widget.deviceToken,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupName,
            style: Styles.textStyledarkBlack14dpBold,
          ),
          subtitle: Text(
            "Join chat with \n${widget.userName}",
            style: Styles.textStyleGrey14dpRegular,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
