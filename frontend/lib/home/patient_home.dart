import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/patients/doctor-list/doctor-list.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../patients/messages/messages.dart';
import '../patients/notifications/notification.dart';
import '../posts/posts.dart';

class PatientHome extends StatefulWidget {
  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  Widget chat(BuildContext ctx) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          fabKey.currentState!.closeFABs();
          Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
            return ChatBot();
          }));
        },
        heroTag: "btn1",
        tooltip: 'Second button',
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget add(BuildContext ctx) {
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

  int index = 0;
  late dynamic provider;
  late dynamic doctors;
  
  void fetchDoctor(BuildContext ctx) async {
    provider = Provider.of<RegisterProvider>(ctx, listen: false)
        .fetchChattedDoctor(provider.me);
  }

  Widget home(BuildContext ctx) {
    Widget homeWidget = Container();
    if (index == 0) {
      homeWidget = Posts();
    } else if (index == 1) {
      homeWidget = Notifications();
    } else if (index == 2) {
      fetchDoctor(ctx);
      homeWidget = DoctorList();
    }
    return homeWidget;
  }

  @override
  Widget build(BuildContext context) {
    fetchDoctor(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 40,
            child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () =>
                    Navigator.pushNamed(context, searchDoctorRoute)),
          ),
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
      body: SingleChildScrollView(child: home(context)),
      floatingActionButton: AnimatedFloatingActionButton(
          key: fabKey,
          fabButtons: <Widget>[
            // add(),
            chat(context),
            add(context),
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
