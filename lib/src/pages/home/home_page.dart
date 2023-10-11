import '/src/common/service/auth_service.dart';
import '/src/data/user_repository.dart';
import 'package:flutter/material.dart';

import '../../common/model/message_model.dart';
import '../../common/model/user_model.dart';
import '../../data/message_repository.dart';
import '../chat_screens/chat_screen.dart';
import 'widgets/account_photo.dart';
import 'widgets/my_listTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IMessageRepository repositoryMessage;
  late IUserRepository repositoryUser;
  late final Stream<MessageModel> messages;
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
          "Chat",
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
            return MyListTile(
              onTap: openChatPage,
              title: AuthService.user.displayName!,
              subtitle: "sd",
              messageCount: 2,
              messageTime: 3,
            );
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
