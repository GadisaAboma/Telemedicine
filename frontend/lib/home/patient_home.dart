import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/patients/contact-list/doctors-list.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../patients/search-doctor/posts/posts.dart';
import '../provider/register.dart';
import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../patients/messages/messages.dart';
import '../patients/notifications/notification.dart';

class PatientHome extends StatefulWidget {
  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  dynamic loggedInUser ;
  @override
  void initState() {
    super.initState();
  loggedInUser  =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    // print(loggedInUser);
    // ClientIO().init(loggedInUser["_id"], loggedInUser["username"]);
  }

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

  // void fetchDoctor(BuildContext ctx) async {
  //   provider = Provider.of<RegisterProvider>(ctx, listen: false)
  //       .fetchChattedDoctor(provider.me);
  // }

  Widget home(BuildContext ctx) {
    Widget homeWidget = Container();
    if (index == 0) {
      homeWidget = Posts();
    } else if (index == 1) {
      homeWidget = Notifications();
    } else if (index == 2) {
      // fetchDoctor(ctx);
      // homeWidget = DoctorList();
    }
    return homeWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loggedInUser['name']),
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
      backgroundColor: Color.fromRGBO(224, 217, 217, 0.87),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (index == 0) Posts(),
            if (index == 1) Notifications(),
            if (index == 2) DoctorsList()
          ],
        ),
      ),
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
