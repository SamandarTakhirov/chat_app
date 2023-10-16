import 'dart:async';

import 'package:chat_application_with_firebase/src/common/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../constants/api_const.dart';

class DatabaseService {
  const DatabaseService();

  static final _database = FirebaseDatabase.instance;

  Stream<DatabaseEvent> readAllData(String dataPath) =>
      _database.ref(dataPath).onValue.asBroadcastStream();

  DatabaseReference queryFromPath(String dataPath) => _database.ref(dataPath);

  Future<void> create(
    String dataPath,
    Map<String, Object?> json,
  ) async {
    final id = _database.ref(dataPath).push().key;
    json['id'] = id;

    await _database.ref(dataPath).child(id!).set(json);
  }

  Future<void> update({
    required String dataPath,
    required String id,
    required Map<String, Object?> json,
  }) =>
      _database.ref(dataPath).child(id).update(json);

  Future<void> delete(String dataPath, String id) =>
      _database.ref(dataPath).child(id).remove();

  static Future<bool> storeUser(
      String email, String password, String username, String uid) async {
    try {
      final folder = _database.ref(ApiConsts.userPath).child(uid);
      final member =
          UserModel(uid: uid, name: username, email: email, password: password);
      await folder.set(member.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }
}
