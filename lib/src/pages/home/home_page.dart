import 'package:flutter/cupertino.dart';

import '/src/data/user_repository.dart';
import 'package:flutter/material.dart';

import '../../common/model/message_model.dart';
import '../../common/model/user_model.dart';
import '../../data/chat_repository.dart';
import '../chat_screens/chat_screen.dart';
import 'widgets/account_photo.dart';
import 'widgets/my_listtile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IMessageRepository repositoryMessage;
  late IUserRepository repositoryUser;
  late final Stream<ChatModel> messages;
  late final Stream<UserModel> user;

  void openChatPage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );

  @override
  void initState() {
    repositoryMessage = const MessageRepository();
    repositoryUser = const UserRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xFF246BFD),
        leading: IconButton(
          style: IconButton.styleFrom(),
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Chats",
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
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(index),
              direction: DismissDirection.endToStart,
              background: const ColoredBox(
                color: Color(0xFFF75555),
                child: Align(
                  alignment: Alignment(.8, 0),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                ),
              ),
              child: MyListTile(
                onTap: openChatPage,
                title: "AuthService",
                subtitle: "sd",
                messageCount: 2,
                messageTime: 3,
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
