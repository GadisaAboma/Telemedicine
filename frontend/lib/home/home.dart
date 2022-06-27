import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../messages/messages.dart';
import '../notifications/notification.dart';
import '../posts/posts.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  // late BuildContext ctx;

  // Widget add() {
  //   return FloatActionButtonText(
  //     onPressed: () {
  //       fabKey.currentState!.animate();
  //     },
  //     icon: Icons.add,
  //     text: "Start",
  //     textLeft: -115,
  //   );
  // }

  Widget chat(BuildContext ctx) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          fabKey.currentState!.closeFABs();
          Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
            return ChatBot();
            
          }));
        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child: Icon(Icons.chat),
      ),
    );
  }

  // Widget inbox() {
  //   return FloatActionButtonText(

  //     onPressed: () {
  //       fabKey.currentState!.animate();
  //     },
  //     icon: Icons.inbox,
  //     textLeft: -135,
  //     text: "Desbloquear",
  //   );
  // }

  int index = 0;

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
        child: Column(
          children: [
            if (index == 0) Posts(),
            if (index == 1) Notifications(),
            if (index == 2) Messages()
          ],
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          key: fabKey,
          fabButtons: <Widget>[
            // add(),
            chat(context),
            chat(context),
            // inbox(),
          ],
          colorStartAnimation: Theme.of(context).primaryColor,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: index,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        onTap: (currentIndex) {
          setState(() {
            index = currentIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            label: "notification",
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: "messages",
            icon: Icon(
              Icons.message,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
