import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/drawer/patient_drawer.dart';
import 'package:frontend/patients/contact-list/doctors-list.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../appointment/appointment_home.dart';
import '../patients/search-doctor/posts/posts.dart';
import '../patients/notifications/notification.dart';
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
  dynamic loggedInUser;
  var count;
  bool reload = false;
  @override
  void initState() {
    super.initState();

    // print(loggedInUser);
    // ClientIO().init(loggedInUser["_id"], loggedInUser["username"]);
    loggedInUser =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    Future.delayed(Duration.zero, () {
      configuration();
    });
  }

  void configuration() async {
    var patientId =
        Provider.of<RegisterProvider>(context, listen: false).loggedId;

    count = await Provider.of<RegisterProvider>(context, listen: false)
        .countNotification(patientId);

    setState(() {
      reload = true;
    });
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
      configuration();
      homeWidget = Notifications();
    } else if (index == 2) {
      // fetchDoctor(ctx);
      // homeWidget = DoctorList();
    }
    return homeWidget;
  }

  Widget setBody() {
    Widget body = Container();
    if (index == 0) body = Posts();
    if (index == 1) body = Notifications();
    if (index == 2)
      body = DoctorsList(
        username: loggedInUser["username"],
      );

    return body;
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
        drawer: PatientDrawer(
          userInfo: loggedInUser,
        ),
       
      
      body: setBody(),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(
          FontAwesomeIcons.bots,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return ChatBot();
          }));
        }, //To principal button
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
        items: [
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
            icon: Stack(children: <Widget>[
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
              Positioned(
                // draw a red marble
                top: 0.0,
                right: 0.0,
                child: count == null
                    ? Container()
                    : int.parse(count) == 0
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              count == null
                                  ? ""
                                  : int.parse(count) == 0
                                      ? ""
                                      : count,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
              )
            ]),
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
