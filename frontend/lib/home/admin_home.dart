import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../posts/posts.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  int index = 0;
  Widget bodyWidget() {
    Widget returnedwidget = Container();
    if (index == 1) {
      returnedwidget = Center(
        child: Text("list of doctors"),
      );
    } else {
      returnedwidget = Center(
        child: Text("admin"),
      );
    }
    return returnedwidget;
  }

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
      body: bodyWidget(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.approval), label: "Approval")
          ]),
    );
  }
}
