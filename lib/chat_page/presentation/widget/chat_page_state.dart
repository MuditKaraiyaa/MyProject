// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // ignore: depend_on_referenced_packages
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:xbridge/chat_page/models/message_chat.dart';
// import 'package:xbridge/chat_page/presentation/screen/chat_page.dart';
// import 'package:xbridge/chat_page/presentation/widget/auth_provider.dart';
// import 'package:xbridge/chat_page/presentation/widget/chat_provider.dart';
// import 'package:xbridge/common/constants/app_colors.dart';
// import 'package:xbridge/common/constants/firestore_constants.dart';
// import 'package:xbridge/common/constants/globals.dart';
// import 'package:xbridge/common/constants/type_message.dart';
// import 'package:xbridge/common/widgets/loading_view.dart';

// class ChatPageState extends State<ChatPage> {
//   // String managerUserID = "e791bc02c3be7d106c1b7bff0501316d";
//   // String FEUserID = "18363f98c3a0421032d8339f050131be";
//   String _currentUserId = "";

//   List<QueryDocumentSnapshot> _listMessage = [];
//   int _limit = 20;
//   final _limitIncrement = 20;
//   String _groupChatId = "";

//   File? _imageFile;
//   bool _isLoading = false;
//   bool _isShowSticker = false;
//   String _imageUrl = "";

//   final _chatInputController = TextEditingController();
//   final _listScrollController = ScrollController();
//   final _focusNode = FocusNode();

//   late final _chatProvider = context.read<ChatProvider>();
//   late final _authProvider = context.read<AuthProvider>();

//   @override
//   void initState() {
//     super.initState();
//     if (_authProvider.userFirebaseId?.isNotEmpty == true) {
//       _currentUserId = _authProvider.userFirebaseId!;
//     }
//     // else {
//     //   _currentUserId = isManager ? managerUserID : FEUserID;
//     // }
//     _readLocal();
//   }

//   void _readLocal() {
//     String peerId = receiverMsgId; //isManager ? FEUserID : managerUserID;
//     if (_currentUserId.compareTo(peerId) > 0) {
//       _groupChatId = '$_currentUserId-$peerId';
//     } else {
//       _groupChatId = '$peerId-$_currentUserId';
//     }

//     _chatProvider.updateDataFirestore(
//       FirestoreConstants.pathGroupCollection,
//       _currentUserId,
//       {FirestoreConstants.chattingWith: peerId},
//     );
//   }

//   Future<bool> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedXFile = await imagePicker
//         .pickImage(source: ImageSource.gallery)
//         .catchError((err) {
//       Fluttertoast.showToast(msg: err.toString());
//       return null;
//     });
//     if (pickedXFile != null) {
//       final imageFile = File(pickedXFile.path);
//       setState(() {
//         _imageFile = imageFile;
//         _isLoading = true;
//       });
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void _getSticker() {
//     // Hide keyboard when sticker appear
//     _focusNode.unfocus();
//     setState(() {
//       _isShowSticker = !_isShowSticker;
//     });
//   }

//   Future<void> _uploadFile() async {
//     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final uploadTask = _chatProvider.uploadFile(_imageFile!, fileName);
//     try {
//       final snapshot = await uploadTask;
//       _imageUrl = await snapshot.ref.getDownloadURL();
//       setState(() {
//         _isLoading = false;
//         _onSendMessage(_imageUrl, TypeMessage.image);
//       });
//     } on FirebaseException catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(msg: e.message ?? e.toString());
//     }
//   }

//   void _onSendMessage(String content, int type) {
//     if (content.trim().isNotEmpty) {
//       _chatInputController.clear();
//       _chatProvider.sendMessage(
//           content, type, _groupChatId, _currentUserId, widget.arguments.peerId);
//       if (_listScrollController.hasClients) {
//         _listScrollController.animateTo(0,
//             duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//       }
//     } else {
//       Fluttertoast.showToast(
//           msg: 'Nothing to send', backgroundColor: AppColors.gray);
//     }
//   }

//   Widget _buildItemMessage(int index, DocumentSnapshot? document) {
//     if (document == null) return SizedBox.shrink();
//     final messageChat = MessageChat.fromDocument(document);
//     if (messageChat.idFrom == _currentUserId) {
//       // Right (my message)
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           messageChat.type == TypeMessage.text
//               // Text
//               ? Container(
//                   padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
//                   width: 200,
//                   decoration: BoxDecoration(
//                       color: AppColors.gray,
//                       borderRadius: BorderRadius.circular(8)),
//                   margin: EdgeInsets.only(
//                       bottom: _isLastMessageRight(index) ? 20 : 10, right: 10),
//                   child: Text(
//                     messageChat.content,
//                     style: TextStyle(color: AppColors.primaryButtonTitleColor),
//                   ),
//                 )
//               : messageChat.type == TypeMessage.image
//                   // Image
//                   ? Container(
//                       clipBehavior: Clip.hardEdge,
//                       decoration:
//                           BoxDecoration(borderRadius: BorderRadius.circular(8)),
//                       margin: EdgeInsets.only(
//                           bottom: _isLastMessageRight(index) ? 20 : 10,
//                           right: 10),
//                       child: GestureDetector(
//                         child: Image.network(
//                           messageChat.content,
//                           loadingBuilder: (_, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.gray,
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(8),
//                                 ),
//                               ),
//                               width: 200,
//                               height: 200,
//                               child: Center(
//                                 child: CircularProgressIndicator(
//                                   color: AppColors.primaryButtonBackgroundColor,
//                                   value: loadingProgress.expectedTotalBytes !=
//                                           null
//                                       ? loadingProgress.cumulativeBytesLoaded /
//                                           loadingProgress.expectedTotalBytes!
//                                       : null,
//                                 ),
//                               ),
//                             );
//                           },
//                           errorBuilder: (_, __, ___) {
//                             return Image.asset(
//                               'images/img_not_available.jpeg',
//                               width: 200,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             );
//                           },
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         ),
//                         onTap: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (_) => FullPhotoPage(
//                           //       url: messageChat.content,
//                           //     ),
//                           //   ),
//                           // );
//                         },
//                       ),
//                     )
//                   // Sticker
//                   : Container(
//                       margin: EdgeInsets.only(
//                           bottom: _isLastMessageRight(index) ? 20 : 10,
//                           right: 10),
//                       child: Image.asset(
//                         'images/${messageChat.content}.gif',
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//         ],
//       );
//     } else {
//       // Left (peer message)
//       return Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ClipOval(
//                   child: _isLastMessageLeft(index)
//                       ? Image.network(
//                           widget.arguments.peerAvatar,
//                           loadingBuilder: (_, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: AppColors.themeMaterialColor,
//                                 value: loadingProgress.expectedTotalBytes !=
//                                         null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                     : null,
//                               ),
//                             );
//                           },
//                           errorBuilder: (_, __, ___) {
//                             return Icon(
//                               Icons.account_circle,
//                               size: 35,
//                               color: AppColors.gray,
//                             );
//                           },
//                           width: 35,
//                           height: 35,
//                           fit: BoxFit.cover,
//                         )
//                       : Container(width: 35),
//                 ),
//                 messageChat.type == TypeMessage.text
//                     ? Container(
//                         padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
//                         width: 200,
//                         decoration: BoxDecoration(
//                             color: AppColors.primaryButtonBackgroundColor,
//                             borderRadius: BorderRadius.circular(8)),
//                         margin: EdgeInsets.only(left: 10),
//                         child: Text(
//                           messageChat.content,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     : messageChat.type == TypeMessage.image
//                         ? Container(
//                             clipBehavior: Clip.hardEdge,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8)),
//                             margin: EdgeInsets.only(left: 10),
//                             child: GestureDetector(
//                               child: Image.network(
//                                 messageChat.content,
//                                 loadingBuilder: (_, child, loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       color: AppColors.grey,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(8),
//                                       ),
//                                     ),
//                                     width: 200,
//                                     height: 200,
//                                     child: Center(
//                                       child: CircularProgressIndicator(
//                                         color: AppColors.themeMaterialColor,
//                                         value: loadingProgress
//                                                     .expectedTotalBytes !=
//                                                 null
//                                             ? loadingProgress
//                                                     .cumulativeBytesLoaded /
//                                                 loadingProgress
//                                                     .expectedTotalBytes!
//                                             : null,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (_, __, ___) => Image.asset(
//                                   'images/img_not_available.jpeg',
//                                   width: 200,
//                                   height: 200,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 width: 200,
//                                 height: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                               onTap: () {
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (_) =>
//                                 //         FullPhotoPage(url: messageChat.content),
//                                 //   ),
//                                 // );
//                               },
//                             ),
//                           )
//                         : Container(
//                             margin: EdgeInsets.only(
//                                 bottom: _isLastMessageRight(index) ? 20 : 10,
//                                 right: 10),
//                             child: Image.asset(
//                               'images/${messageChat.content}.gif',
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//               ],
//             ),

//             // Time
//             _isLastMessageLeft(index)
//                 ? Container(
//                     margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
//                     child: Text(
//                       DateFormat('dd MMM kk:mm').format(
//                           DateTime.fromMillisecondsSinceEpoch(
//                               int.parse(messageChat.timestamp))),
//                       style: TextStyle(
//                           color: AppColors.gray,
//                           fontSize: 12,
//                           fontStyle: FontStyle.italic),
//                     ),
//                   )
//                 : SizedBox.shrink()
//           ],
//         ),
//       );
//     }
//   }

//   bool _isLastMessageLeft(int index) {
//     if ((index > 0 &&
//             _listMessage[index - 1].get(FirestoreConstants.idFrom) ==
//                 _currentUserId) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool _isLastMessageRight(int index) {
//     if ((index > 0 &&
//             _listMessage[index - 1].get(FirestoreConstants.idFrom) !=
//                 _currentUserId) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void _onBackPress() {
//     _chatProvider.updateDataFirestore(
//       FirestoreConstants.pathGroupCollection,
//       _currentUserId,
//       {FirestoreConstants.chattingWith: null},
//     );
//     Navigator.pop(context);
//   }

//   Widget _buildListMessage() {
//     return Flexible(
//       child: _groupChatId.isNotEmpty
//           ? StreamBuilder<QuerySnapshot>(
//               stream: _chatProvider.getChatStream(_groupChatId, _limit),
//               builder: (_, snapshot) {
//                 if (snapshot.hasData) {
//                   _listMessage = snapshot.data!.docs;
//                   if (_listMessage.length > 0) {
//                     return ListView.builder(
//                       padding: EdgeInsets.all(10),
//                       itemBuilder: (_, index) =>
//                           _buildItemMessage(index, snapshot.data?.docs[index]),
//                       itemCount: snapshot.data?.docs.length,
//                       reverse: true,
//                       controller: _listScrollController,
//                     );
//                   } else {
//                     return Center(child: Text("No message here yet..."));
//                   }
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.themeMaterialColor,
//                     ),
//                   );
//                 }
//               },
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.themeMaterialColor,
//               ),
//             ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: PopScope(
//         canPop: false,
//         onPopInvoked: (didPop) {
//           if (didPop) return;
//           _onBackPress();
//         },
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 _buildListMessage(),
//                 _isShowSticker ? _buildStickers() : SizedBox.shrink(),
//                 _buildInput(),
//               ],
//             ),
//             Positioned(
//               child: _isLoading ? LoadingView() : SizedBox.shrink(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStickers() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(top: BorderSide(color: AppColors.gray, width: 0.5)),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildItemSticker("mimi1"),
//               _buildItemSticker("mimi2"),
//               _buildItemSticker("mimi3"),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildItemSticker("mimi4"),
//               _buildItemSticker("mimi5"),
//               _buildItemSticker("mimi6"),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildItemSticker("mimi7"),
//               _buildItemSticker("mimi8"),
//               _buildItemSticker("mimi9"),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildItemSticker(String stickerName) {
//     return TextButton(
//       onPressed: () => _onSendMessage(stickerName, TypeMessage.sticker),
//       child: Image.asset(
//         'images/$stickerName.gif',
//         width: 50,
//         height: 50,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget _buildInput() {
//     return Container(
//       padding: EdgeInsets.only(left: 20.0),
//       width: double.infinity,
//       height: 50,
//       decoration: BoxDecoration(
//           border:
//               Border(top: BorderSide(color: AppColors.borderColor, width: 0.5)),
//           color: Colors.white),
//       child: Row(
//         children: [
//           // button send image
//           // Material(
//           //   color: Colors.white,
//           //   child: Container(
//           //     margin: EdgeInsets.symmetric(horizontal: 1),
//           //     child: IconButton(
//           //       icon: Icon(Icons.image),
//           //       onPressed: () {
//           //         _pickImage().then((isSuccess) {
//           //           if (isSuccess) _uploadFile();
//           //         });
//           //       },
//           //       color: AppColors.primaryButtonBackgroundColor,
//           //     ),
//           //   ),
//           // ),
//           // Material(
//           //   color: Colors.white,
//           //   child: Container(
//           //     margin: EdgeInsets.symmetric(horizontal: 1),
//           //     child: IconButton(
//           //       icon: Icon(Icons.face),
//           //       onPressed: _getSticker,
//           //       color: AppColors.primaryButtonBackgroundColor,
//           //     ),
//           //   ),
//           // ),

//           // chat input
//           Flexible(
//             child: Container(
//               child: TextField(
//                 onSubmitted: (_) {
//                   _onSendMessage(_chatInputController.text, TypeMessage.text);
//                 },
//                 style: TextStyle(
//                     color: AppColors.primaryButtonBackgroundColor,
//                     fontSize: 15),
//                 controller: _chatInputController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Type your message...',
//                   hintStyle: TextStyle(color: AppColors.gray),
//                 ),
//                 focusNode: _focusNode,
//               ),
//             ),
//           ),

//           // Button send message
//           Material(
//             color: Colors.white,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 8),
//               child: IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () =>
//                     _onSendMessage(_chatInputController.text, TypeMessage.text),
//                 color: AppColors.primaryButtonBackgroundColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatPageArguments {
//   final String peerId;
//   final String peerAvatar;
//   final String peerNickname;

//   ChatPageArguments(
//       {required this.peerId,
//       required this.peerAvatar,
//       required this.peerNickname});
// }
