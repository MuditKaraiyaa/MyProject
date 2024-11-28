import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbridge/chat_page/models/user_chat.dart';
import 'package:xbridge/common/constants/firestore_constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPrefHelper prefs;

  AuthProvider({
    required this.firebaseAuth,
    required this.prefs,
    required this.firebaseFirestore,
  });

  Status _status = Status.uninitialized;

  Status get status => _status;

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await isUserLoggedIn();
    String? id = await prefs.get(FirestoreConstants.id, defaultValue: '');
    if (isLoggedIn && id?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? loggedInUserName = prefs.getString(SharedPrefHelper.userName);
    if (loggedInUserName == null) {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }

    final firebaseTaskUser = (await firebaseAuth.signInAnonymously()).user;
    final firebaseUser = (await firebaseAuth.signInAnonymously()).user;

    // (await firebaseAuth.signInWithCustomToken(loggedInUserName ?? ""))
    //     .user; //signInWithCredential(credential)).user;
    if (firebaseTaskUser == null) {
      _status = Status.authenticateError;
      notifyListeners();
      return false;
    }

    if (firebaseUser == null) {
      _status = Status.authenticateError;
      notifyListeners();
      return false;
    }

    final result = await firebaseFirestore
        .collection(FirestoreConstants.pathGroupCollection)
        .where(FirestoreConstants.id, isEqualTo: taskId)
        .get();
    final documents = result.docs;
    if (documents.isEmpty) {
      // Writing data to server because here is a new user
      firebaseFirestore
          .collection(FirestoreConstants.pathGroupCollection)
          .doc(taskId)
          .collection(FirestoreConstants.pathUserCollection)
          .add({
        FirestoreConstants.nickname: firebaseUser.displayName,
        // FirestoreConstants.photoUrl: firebaseUser.photoURL,
        FirestoreConstants.id: firebaseUser.uid,
        FirestoreConstants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        FirestoreConstants.chattingWith: null,
      });

      // Write data to local storage
      User? currentUser = firebaseUser;
      await prefs.setString(FirestoreConstants.id, currentUser.uid);
      await prefs.setString(
        FirestoreConstants.nickname,
        currentUser.displayName ?? "",
      );
      await prefs.setString(
        FirestoreConstants.photoUrl,
        currentUser.photoURL ?? "",
      );
    } else {
      // Already sign up, just get data from firestore
      final documentSnapshot = documents.first;
      // final userChat = MessageChat.fromDocument(documentSnapshot);
      final userChat = UserChat.fromDocument(documentSnapshot);

      // Write data to local
      await prefs.setString(FirestoreConstants.id, userChat.id);
      await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
      await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
      // await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
    }
    _status = Status.authenticated;
    notifyListeners();
    return true;
  }

  void handleException() {
    _status = Status.authenticateException;
    notifyListeners();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
  }
}
