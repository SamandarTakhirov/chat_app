
import 'package:chat_application_with_firebase/src/common/service/auth_service.dart';
import 'package:chat_application_with_firebase/src/features/data/notification_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/message_repository.dart';
import '/src/common/model/message_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../home/widgets/account_photo.dart';
import 'widgets/chat_mixin.dart';
import 'widgets/write_text.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String id;

  const ChatScreen({
    required this.id,
    required this.name,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ChatMixin{
  @override
  late IMessageRepository repository;
  late INotificationRepository notificationRepository;
  late TextEditingController textEditingController;
  bool isTexting = false;

  @override
  void initState() {
    repository = MessageRepository(widget.id);
    notificationRepository = NotificationRepository(widget.id);
    textEditingController = TextEditingController();
    super.initState();
  }

  Future<void> sendMessage() async {
    final message = MessageModel(
      userId: AuthService.auth.currentUser!.uid,
      message: textEditingController.text.trim(),
    );
    if (textEditingController.text.isNotEmpty) {
      repository.createMessage(message);
      notificationRepository.sendNotification(
        message.id,
        "c71DJET4RheDI4Bi0TfYts:APA91bH1G_r4S4qjH9GSuLpmR4E5CWnsL1L1eRE-gya7C1FdaDpoYFshLTzjupbQquaqAjZtK6qfGsSE0BeAEM4_MvzFe2nBda4poa7PenJwEDQ_BBZVVIQCpDkfjFcKp1KiQwfSmhsb",
        textEditingController.text.trim(),
      );
    }
    textEditingController.text = "";
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
        backgroundColor: const Color(0xFFFFFFFF),
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () => setState(() {
            Navigator.pop(context);
          }),
          child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.back,
                  color: Color(0xFF037EE5),
                ),
                Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF037EE5),
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
             Text(
              "last seen just now",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF787878),
              ),
            ),
          ],
        ),
        actions:  [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AccountPhoto(),
          )
        ],
      ),
      body: Stack(
        children: [
           Image(
            image: AssetImage("assets/images/bkg.jpg"),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
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
                    padding:  EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 10),
                    child: Align(
                      alignment:
                          post.userId != AuthService.auth.currentUser!.uid
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
                                  post.userId ==
                                          AuthService.auth.currentUser!.uid
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
                                                  onChanged: (text) {},
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
                              bottomLeft: post.userId !=
                                      AuthService.auth.currentUser!.uid
                                  ? const Radius.circular(0)
                                  : const Radius.circular(15),
                              topRight: const Radius.circular(15),
                              bottomRight: post.userId !=
                                      AuthService.auth.currentUser!.uid
                                  ? const Radius.circular(15)
                                  : const Radius.circular(0),
                            ),
                            border: Border.all(
                              color: post.userId !=
                                      AuthService.auth.currentUser!.uid
                                  ? Colors.black
                                  : const Color(0xFF21C004),
                              width: 0.2,
                            ),
                            color:
                                post.userId != AuthService.auth.currentUser!.uid
                                    ? const Color(0xFFF5F5F5)
                                    : const Color(0xFFE1FEC6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: post.userId !=
                                      AuthService.auth.currentUser!.uid
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  post.message,
                                  style: TextStyle(
                                    color: post.userId !=
                                            AuthService.auth.currentUser!.uid
                                        ? Colors.black
                                        : Colors.black,
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
                                        color: post.userId !=
                                                AuthService
                                                    .auth.currentUser!.uid
                                            ? Colors.black
                                            : const Color(0xFF2DA430),
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      " ${"${post.createAt.hour}".padLeft(2, "0")}:${"${post.createAt.minute}".padLeft(2, "0")}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: post.userId !=
                                                AuthService
                                                    .auth.currentUser!.uid
                                            ? Colors.black
                                            : const Color(0xFF2DA430),
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
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: 60,
              child: ColoredBox(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                        getMedia(MediaSource.gallery),
                      icon: const Image(
                        image: AssetImage("assets/images/ic_send.png"),
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: SizedBox(
                        width: size.width * 0.75,
                        child: WriteText(
                          onChanged: (text) {
                            setState(() {
                              textEditingController.text.isNotEmpty
                                  ? isTexting = true
                                  : isTexting = false;
                            });
                          },
                          textEditingController: textEditingController,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: sendMessage,
                      icon: Image(
                        width: 30,
                        height: 30,
                        image: const AssetImage(
                          "assets/images/ic_send_message.png",
                        ),
                        color: !isTexting
                            ? const Color(0xFFB9B9BA)
                            : const Color(0xFF007AFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


