import 'package:chat_application_with_firebase/src/common/model/message_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../data/chat_repository.dart';
import '../home/widgets/account_photo.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IMessageRepository repository;
  late TextEditingController textEditingController;
  List<String> allMessage = [];

  @override
  void initState() {
    repository = const MessageRepository();
    textEditingController = TextEditingController();
    super.initState();
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
        title: const Text(
          "Qobil",
          style: TextStyle(
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
                final aValue = ChatModel.fromJson(
                  Map<String, Object?>.from(a.value as Map),
                );

                final bValue = ChatModel.fromJson(
                  Map<String, Object?>.from(b.value as Map),
                );

                return aValue.createdAt.compareTo(bValue.createdAt);
              },
              query: repository.queryMessage(),
              itemBuilder: (context, snapshot, animation, index) {
                final post = ChatModel.fromJson(
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
                      alignment: post.userOne == 1
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15),
                            bottomLeft: post.userOne == 1
                                ? const Radius.circular(0)
                                : const Radius.circular(15),
                            topRight: const Radius.circular(15),
                            bottomRight: post.userOne == 1
                                ? const Radius.circular(15)
                                : const Radius.circular(0),
                          ),
                          color: post.userOne == 1
                              ? const Color(0xFFF5F5F5)
                              : const Color(0xFF246BFD),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: post.userOne == 1
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                post.message,
                                style: TextStyle(
                                  color: post.userOne == 1
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "${"${post.createdAt.hour}".padLeft(
                                    2, "0")}:${"${post.createdAt.minute}"
                                    .padLeft(2, "0")}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: post.userOne == 1
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
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
                children: [
                  SizedBox(
                    width: size.width * 0.85,
                    child: TextField(
                      autofocus: true,
                      controller: textEditingController,
                      textInputAction: TextInputAction.newline,
                      cursorColor: const Color(0xFF20A090),
                      decoration: const InputDecoration(
                        focusColor: Color(0xFF246BFD),
                        hintText: "Write your message",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF246BFD),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      allMessage.add(textEditingController.text.trim());
                      ChatModel message = ChatModel(
                        messages: allMessage,
                        id: "2",
                        message: textEditingController.text.trim(),
                      );
                      textEditingController.clear();
                      repository.createMessage(message);
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                      color: Color(0xFF246BFD),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
