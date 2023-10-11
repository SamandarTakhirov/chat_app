import 'dart:convert';
import 'dart:io';

import 'package:chat_application_with_firebase/src/common/model/message_model.dart';
import 'package:chat_application_with_firebase/src/common/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'auth_service.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;



  /// user
  static Future<bool> storeUser(String email, String password, String username, String uid) async {
    try {
      final folder = db.ref(Folder.user).child(uid);
      final member = UserModel(id: uid, name: username, email: email, password: password);
      await folder.set(member.toJson());
      return true;
    } catch(e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<UserModel?> readUser(String uid) async {
    try {
      final data = db.ref(Folder.user).child(uid).get();
      final member = UserModel.fromJson(jsonDecode(jsonEncode(data)) as Map<String, Object>);
      return member;
    } catch(e) {
      debugPrint("DB ERROR: $e");
      return null;
    }
  }

}

sealed class Folder {
  static const user = "User";
}

