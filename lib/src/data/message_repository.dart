import 'dart:async';

import 'package:chat_application_with_firebase/src/common/constants/api_const.dart';
import 'package:chat_application_with_firebase/src/common/service/database_service.dart';
import 'package:firebase_database/firebase_database.dart';

import '../common/model/message_model.dart';

abstract interface class IMessageRepository {
  DatabaseReference queryMessage();

  Stream<MessageModel> getAllData();

  Future<void> createMessage(MessageModel message);

  Future<void> deleteMessage(String id);

  Future<void> updateMessage(MessageModel message);
}

class MessageRepository implements IMessageRepository {
  const MessageRepository() : _service = const DatabaseService();

  final DatabaseService _service;

  @override
  Stream<MessageModel> getAllData() =>
      _service.readAllData(ApiConsts.messagePath).transform(
        StreamTransformer<DatabaseEvent, MessageModel>.fromHandlers(
            handleData: (data, sink) {
          for (final json in (data.snapshot.value as Map).values) {
            final message =
                MessageModel.fromJson(Map<String, Object?>.from(json));
            sink.add(message);
          }
        }),
      );

  @override
  Future<void> createMessage(MessageModel message) =>
      _service.create(ApiConsts.messagePath, message.toJson());

  @override
  DatabaseReference queryMessage() =>
      _service.queryFromPath(ApiConsts.messagePath);

  @override
  Future<void> deleteMessage(String id) =>
      _service.delete(ApiConsts.messagePath, id);

  @override
  Future<void> updateMessage(MessageModel message) => _service.update(
        dataPath: ApiConsts.messagePath,
        id: message.id,
        json: message.toJson(),
      );

}
