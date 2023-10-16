import 'package:chat_application_with_firebase/src/common/model/user_model.dart';
import 'package:chat_application_with_firebase/src/pages/home/widgets/my_listtile.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../profile/profile_page.dart';
import '/src/common/service/auth_service.dart';
import '/src/data/user_repository.dart';
import 'package:flutter/material.dart';

import '../../data/message_repository.dart';
import '../chat_screens/chat_screen.dart';
import 'widgets/account_photo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IMessageRepository repositoryMessage;
  late IUserRepository repositoryUser;

  void openChatPage(String name, String id) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(name: name, id: id),
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
                builder: (context) => const ChatScreen(name: "", id: '',),
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
          itemBuilder: (context, snapshot, animation, index) {
            final post = UserModel.fromJson(
              Map<String, Object?>.from(snapshot.value as Map),
            );

            final id = [post.uid, AuthService.auth.currentUser!.uid]..sort();
            return post.email != AuthService.auth.currentUser!.email
                ? MyListTile(
                    widget: CircleAvatar(
                      maxRadius: 25,
                      minRadius: 25,
                      backgroundColor: Colors.primaries[index % 15],
                      child: const Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => openChatPage(
                      post.name!,
                      id.join(),
                    ),
                    title: post.name ?? "",
                    subtitle: post.email,
                    messageCount: 33,
                    messageTime: 32,
                  )
                : const SizedBox.shrink();
          },
          query: repositoryUser.queryUser(),
        ),
      ),
    );
  }
}
