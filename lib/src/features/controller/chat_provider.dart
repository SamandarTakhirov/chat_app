import 'package:flutter/material.dart';

import '../../common/model/message_model.dart';


class ChatProvider extends ChangeNotifier {
  MessageModel? defineChat;

  void updateDefineChat() {
    defineChat = null;
    // print("defineChat: $defineChat");
    notifyListeners();
  }

  void uploadMessage(MessageModel messageModel) {
    defineChat = messageModel;
    notifyListeners();
  }
}
