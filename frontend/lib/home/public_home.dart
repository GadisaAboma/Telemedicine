import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../messages/messages.dart';
import '../notifications/notification.dart';
import '../posts/posts.dart';

class PublicHome extends StatefulWidget {
  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              labelText: "Search",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              size: 30,
            ),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Posts(),
      ),
    );
  }
}
