import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../common/model/message_model.dart';
import '../profile/profile_page.dart';
import '/src/common/service/auth_service.dart';
import '/src/data/user_repository.dart';
import 'package:flutter/material.dart';

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

  void openChatPage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );

  void openProfilePage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF246BFD),
        onPressed: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ),
            );
          });
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AccountPhoto(
              onTap: openProfilePage,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          sort: (a, b) {
            final aValue = MessageModel.fromJson(
              Map<String, Object?>.from(a.value as Map),
            );

            final bValue = MessageModel.fromJson(
              Map<String, Object?>.from(b.value as Map),
            );

            return bValue.createAt.compareTo(aValue.createAt);
          },
          itemBuilder: (context, snapshot, animation, index) {
            final post = MessageModel.fromJson(
              Map<String, Object?>.from(snapshot.value as Map),
            );

            return MyListTile(
              onTap: openChatPage,
              title: "${AuthService.auth.currentUser?.displayName}",
              subtitle: post.message,
              messageCount: post.message.length,
              messageTime: DateTime.now().minute - post.createAt.minute,
            );
          },
          query: repositoryMessage.queryMessage(),
        ),
      ),
    );
  }
}
