import 'package:chat_application_with_firebase/src/common/service/auth_service.dart';

import '/src/common/model/message_model.dart';
import '/src/data/message_repository.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../home/widgets/account_photo.dart';
import 'widgets/write_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IMessageRepository repository;
  late TextEditingController textEditingController;

  @override
  void initState() {
    repository = const MessageRepository();
    textEditingController = TextEditingController();
    super.initState();
  }

  void sendMessage() {
    final message = MessageModel(
      userId: "2",
      message: textEditingController.text.trim(),
    );
    if (textEditingController.text.isNotEmpty) {
      repository.createMessage(message);
    }
    textEditingController.clear();
  }

  void editPost(MessageModel message) async {
    final editMessage = MessageModel(
      userId: message.userId,
      message: textEditingController.text == ""
          ? message.message
          : textEditingController.text,
      id: message.id,
      edited: true,
    );

    await repository.updateMessage(editMessage);

    if (context.mounted) {
      Navigator.pop(context);
    }

    textEditingController.text = "";
  }

  Future<void> deletePost(String id) async {
    await repository.deleteMessage(id);

    if (context.mounted) {
      Navigator.pop<bool>(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF246BFD),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: BackButton(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title:  Text(
          "${AuthService.auth.currentUser!.displayName}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AccountPhoto(),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 85),
            child: FirebaseAnimatedList(
              reverse: true,
              sort: (a, b) {
                final aValue = MessageModel.fromJson(
                  Map<String, Object?>.from(a.value as Map),
                );

                final bValue = MessageModel.fromJson(
                  Map<String, Object?>.from(b.value as Map),
                );

                return bValue.createAt.compareTo(aValue.createAt);
              },
              query: repository.queryMessage(),
              itemBuilder: (context, snapshot, animation, index) {
                final post = MessageModel.fromJson(
                  Map<String, Object?>.from(snapshot.value as Map),
                );
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.5,
                    minWidth: size.width * 0.5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 10),
                    child: Align(
                      alignment: post.userId == "1"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  post.userId == "2"
                                      ? IconButton(
                                          onPressed: () => showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                top: 10,
                                                right: 10,
                                                left: 10,
                                              ),
                                              child: SizedBox(
                                                width: size.width,
                                                child: WriteText(
                                                  suffixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          editPost(post),
                                                      style: FilledButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF246BFD),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  textEditingController:
                                                      textEditingController,
                                                ),
                                              ),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Color(0xFF246BFD),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  IconButton(
                                    onPressed: () => deletePost(post.id),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color(0xFFFF0000),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15),
                              bottomLeft: post.userId == "1"
                                  ? const Radius.circular(0)
                                  : const Radius.circular(15),
                              topRight: const Radius.circular(15),
                              bottomRight: post.userId == "1"
                                  ? const Radius.circular(15)
                                  : const Radius.circular(0),
                            ),
                            color: post.userId == "1"
                                ? const Color(0xFFF5F5F5)
                                : const Color(0xFF246BFD),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: post.userId == "1"
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  post.message,
                                  style: TextStyle(
                                    color: post.userId == "1"
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      post.edited ? "edited" : "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: post.userId == "1"
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      " ${"${post.createAt.hour}".padLeft(2, "0")}:${"${post.createAt.minute}".padLeft(2, "0")}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: post.userId == "1"
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.file_upload_outlined,
                      size: 30,
                      color: Color(0xFF246BFD),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.70,
                    child: WriteText(
                      textEditingController: textEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                      color: Color(0xFF246BFD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
