import 'dart:io';

import 'package:chat_application_with_firebase/src/features/data/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../common/model/message_model.dart';
import '../../../../common/service/auth_service.dart';
import '../../../controller/ChatProvider.dart';
import '../chat_screen.dart';

mixin ChatMixin on State<ChatScreen> {
  late final TextEditingController controller;
  late final IMessageRepository repository;
  late final String id;
  File? file;

  @override
  void initState() {
    controller = TextEditingController();
    repository = MessageRepository(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onEditSelected(MessageModel messageModel) {
    context.read<ChatProvider>().uploadMessage(messageModel);
    controller.clear();
    controller.text =
        Provider.of<ChatProvider>(context, listen: false).defineChat?.message ??
            "";
    Navigator.pop(context);
  }

  void updateMessage() {
    final message = MessageModel(
      userId: AuthService.auth.currentUser!.uid,
      id: Provider.of<ChatProvider>(context, listen: false).defineChat!.id,
      message: controller.text,
    );
    repository.updateMessage(
      message,
    );
    context.read<ChatProvider>().updateDefineChat();
    controller.clear();
  }

  void deleteMessage(String id) {
    repository.deleteMessage(id);
    Navigator.pop(context);
  }

  Future<void> getMedia(MediaSource mediaSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: mediaSource.name == "camera"
          ? ImageSource.camera
          : ImageSource.gallery,
    );

    if (pickedImage != null) file = File(pickedImage.path);
  }
}

enum MediaSource {
  camera("camera"),
  gallery("gallery");

  const MediaSource(this.mediaSource);

  final String mediaSource;
}
