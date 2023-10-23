import 'package:chat_application_with_firebase/src/common/service/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'database_service.dart';

sealed class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<bool> registration(String email, String password,
      String username) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);

        await DatabaseService.storeUser(email, password, username,
            credential.user!.uid, $deviceToken);
      }

      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> logOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static User? get user => auth.currentUser;
}
