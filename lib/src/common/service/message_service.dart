import 'dart:async';

import 'package:chat_application_with_firebase/src/common/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class DBService {
  const DBService();

  static final _database = FirebaseDatabase.instance;

  Stream<DatabaseEvent> readAllData(String dataPath) =>
      _database
          .ref(dataPath)
          .onValue
          .asBroadcastStream();

  DatabaseReference queryFromPath(String dataPath) => _database.ref(dataPath);

  Future<void> create(String dataPath,
      Map<String, Object?> json, {required UserModel userModel,}) async {
    final id = _database
        .ref(dataPath)
        .push()
        .key;
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
}
