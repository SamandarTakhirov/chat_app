import 'dart:async';

import 'package:chat_application_with_firebase/src/common/constants/api_const.dart';
import 'package:chat_application_with_firebase/src/common/service/database_service.dart';
import 'package:firebase_database/firebase_database.dart';

import '../common/model/message_model.dart';

abstract interface class IMessageRepository {
  DatabaseReference queryMessage();
  Stream<ChatModel> getAllData();

  Future<void> createMessage(ChatModel message);

  Future<void> deleteMessage(String id);

  Future<void> updateMessage(ChatModel message);
}

class MessageRepository implements IMessageRepository {

  const MessageRepository() : _service = const DatabaseService();

  final DatabaseService _service;

  @override
  Stream<ChatModel> getAllData() =>
      _service.readAllData(ApiConsts.chatPath).transform(
        StreamTransformer<DatabaseEvent, ChatModel>.fromHandlers(
            handleData: (data, sink) {
          for (final json in (data.snapshot.value as Map).values) {
            final message =
                ChatModel.fromJson(Map<String, Object?>.from(json));
            sink.add(message);
          }
        }),
      );

  @override
  Future<void> createMessage(ChatModel message) => _service.create(ApiConsts.chatPath, message.toJson());

  @override
  DatabaseReference queryMessage() => _service.queryFromPath(ApiConsts.chatPath);

  @override
  Future<void> deleteMessage(String id) =>  _service.delete(ApiConsts.chatPath,id);

  @override
  Future<void> updateMessage(ChatModel message) => _service.update(
    dataPath: ApiConsts.chatPath,
    id: message.id,

    json: message.toJson(),
  );
}
