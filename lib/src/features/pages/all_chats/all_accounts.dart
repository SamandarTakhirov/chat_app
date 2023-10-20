import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/model/user_model.dart';
import '../../../common/service/auth_service.dart';
import '../../data/message_repository.dart';
import '../../data/user_repository.dart';
import '../chat_screens/chat_screen.dart';
import '../home/widgets/my_listtile.dart';

class AllAccount extends StatefulWidget {
  const AllAccount({Key? key}) : super(key: key);

  @override
  State<AllAccount> createState() => _AllAccountState();
}

class _AllAccountState extends State<AllAccount> {
  late IMessageRepository repositoryMessage;
  late IUserRepository repositoryUser;

  void openChatPage(String name, String id) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(name: name, id: id),
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
        centerTitle: true,
        title: Text(
          "Contacts",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(),
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Color(0xFF007AFF),
              size: 30,
            ),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
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
                      subtitle: "last seen recently",
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
                    ),
                  ],
                )
              : const SizedBox.shrink();
        },
        query: repositoryUser.queryUser(),
      ),
    );
  }
}
