import 'package:firebase_auth/firebase_auth.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/service/database_service.dart';
import 'package:xbridge/common/utils/helper_function.dart';

/// Service class for handling authentication operations.
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Logs in a user with their email and password.
  ///
  /// Returns `true` if login is successful, otherwise returns an error message.
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user =
          (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Logs in a user anonymously.
  ///
  /// Returns `true` if login is successful, otherwise returns an error message.
  Future loginWitAnonymously() async {
    try {
      User user = (await firebaseAuth.signInAnonymously()).user!;
      var name = await getUserFullLastName();
      // call our database service to update the user data.
      await DatabaseService(uid: user.uid).savingUserData(name, userName);
      return true;

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Registers a new user with their full name, email, and password.
  ///
  /// Returns `true` if registration is successful, otherwise returns an error message.
  Future registerUserWithEmailandPassword(String fullName, String email, String password) async {
    try {
      User user =
          (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
              .user!;

      // call our database service to update the user data.
      await DatabaseService(uid: user.uid).savingUserData('$firstName $lastName', email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// Signs out the current user.
  ///
  /// Clears user-related data stored in shared preferences.
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
