import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../common/model/user_model.dart';
import '../common/service/database_service.dart';
import '/src/common/constants/api_const.dart';


abstract interface class IUserRepository {
  DatabaseReference queryUser();

  Stream<UserModel> getAllUser();

  Future<void> createUser(UserModel user);

  Future<void> deleteUser(String id);

  Future<void> updateUser(UserModel user);
}

class UserRepository implements IUserRepository {
  const UserRepository() : _service = const DatabaseService();

  final DatabaseService _service;

  @override
  Stream<UserModel> getAllUser() =>
      _service.readAllData(ApiConsts.userPath).transform(
        StreamTransformer<DatabaseEvent, UserModel>.fromHandlers(
            handleData: (data, sink) {
              for (final json in (data.snapshot.value as Map).values) {
                final user = UserModel.fromJson(Map<String, Object?>.from(json));
                sink.add(user);
              }
            }),
      );


  @override
  Future<void> createUser(UserModel user) =>
      _service.create(ApiConsts.userPath, user.toJson());

  @override
  DatabaseReference queryUser() => _service.queryFromPath(ApiConsts.userPath);

  @override
  Future<void> deleteUser(String id) => _service.delete(ApiConsts.userPath, id);

  @override
  Future<void> updateUser(UserModel user) => _service.update(
    dataPath: ApiConsts.messagePath,
    id: user.uid,
    json: user.toJson(),
  );

  @override
  String toString() {
    return 'UserRepository{_service: $_service}';
  }
}