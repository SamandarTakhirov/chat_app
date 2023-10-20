import 'package:chat_application_with_firebase/src/common/model/user_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

import '../../data/user_repository.dart';
import '../profile/profile_page.dart';
import '/src/common/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../data/message_repository.dart';
import '../chat_screens/chat_screen.dart';
import 'widgets/my_listtile.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        leading: TextButton(
          style: TextButton.styleFrom(),
          onPressed: () {},
          child: Text(
            "Edit",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF037EE5),
                ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Chats",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(),
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/images/ic_edit.png"),
              width: 22,
              height: 22,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(355, 36),
          child: SizedBox(
            width: 355,
            height: 36,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x1F767680),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image(
                        width: 15,
                        height: 15,
                        image: AssetImage("assets/images/ic_search.png"),
                      ),
                    ),
                    Text(
                      "Search for messages or users",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF3C3C43),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          itemBuilder: (context, snapshot, animation, index) {
            final post = UserModel.fromJson(
              Map<String, Object?>.from(snapshot.value as Map),
            );

            final id = [post.uid, AuthService.auth.currentUser!.uid]..sort();
            return post.email != AuthService.auth.currentUser!.email
                ? Column(
                  children: [
                    MyListTile(
                        widget: CircleAvatar(
                          maxRadius: 25,
                          minRadius: 25,
                          backgroundColor: Colors.primaries[index % 15],
                          child: const Icon(
                            CupertinoIcons.profile_circled,
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
                        messageTime: DateTime.now().minute,
                      ),
                    const Padding(
                      padding: EdgeInsets.only(left: 80.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: ColoredBox(
                          color: Color(0xFFD8D8D8),
                        ),
                      ),
                    )
                  ],
                )
                : const SizedBox.shrink();
          },
          query: repositoryUser.queryUser(),
        ),
      ),
    );
  }
}