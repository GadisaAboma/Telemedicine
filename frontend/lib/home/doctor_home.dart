import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/home/patient_home.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../chatbot/chatbot.dart';
import '../doctor/doctor_profile.dart';
import '../drawer/drawer.dart';
import '../provider/message.dart';
import '../provider/register.dart';
import '../views/chat/chat_page.dart';
import '../posts/widgets/each_place.dart';

class DoctorHome extends StatefulWidget {
  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  bool isLoading = true;
  List places = [];

  void fetchPosts() async {
    await Provider.of<PatientProvider>(context, listen: false).fetchPosts();
    places = Provider.of<PatientProvider>(context, listen: false).places;
    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  int index = 0;
  dynamic doctorInfo;

  @override
  void initState() {
    doctorInfo =
        Provider.of<RegisterProvider>(context, listen: false).doctordInfo;

    final loggedInUser =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    // ClientIO().init(loggedInUser["_id"], loggedInUser["username"]);
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        fetchPosts();
      },
    );
  }

  void setNavigation(int navagateIndex) {
    if (navagateIndex == 0) {
      index = 0;
    } else if (navagateIndex == 1) {
      index = 1;
    }
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
        heroTag: "btn2",
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
        heroTag: "btn1",
        tooltip: 'Second button',
        child: Icon(Icons.add),
      ),
    );
  }

  // SocketService? s;

  Widget listOfPatient(BuildContext ctx) {
   dynamic doctor = doctorInfo["messages"].reversed.toList();
    return ListView.builder(
        itemCount: doctorInfo["messages"].length,
        itemBuilder: (context, index) {
          Widget listOfPatient = Container();
          (doctorInfo["messages"] as List).length == 1
              ? listOfPatient = Center(child: Text("There is no user yet"))
              : listOfPatient = Column(
                  children: [
                    if (index != 0)
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 6, right: 15, left: 15),
                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              // SocketService.init();
                              final chat =
                                  Provider.of<PreviousChat>(ctx, listen: false);
                              final patient = await Provider.of<
                                      PatientProvider>(context, listen: false)
                                  .patient(
                                      doctorInfo["messages"][index]["user"]);
                              chat.setUserName(doctorInfo["username"]);
                              chat.setReciever(
                                  doctorInfo["messages"][index]["user"]);
                              chat.setSender(doctorInfo["username"]);
                              (doctorInfo["messages"][index]["content"] as List)
                                  .forEach((data) {
                                (data as Map).remove("_id");
                                // print(data);
                                chat.addToChatHistory(data);
                              });
                              print(chat.chatHistory);

                              chat.connectAndListen(doctorInfo["username"]);

                              // print("patient" + patient);
                              Navigator.pushNamed(context, chatPageRoute,
                                  arguments: {
                                    "id": patient["_id"],
                                    "username": patient["username"]
                                  });
                            },
                            title: Text(doctorInfo["messages"][index]["user"]),
                            leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent),
                            trailing: Icon(
                              Icons.done_all,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
          return listOfPatient;
        });
  }

  Widget SetBody(BuildContext ctx) {
    Widget returnedWidget;
    if (index == 0) {
      returnedWidget = isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, i) => EachPlace(
                    places[i]['description'],
                    places[i]['imageUrl'].toString().replaceAll('\\', '/'),
                    places[i]['date'],
                    places[i]['doctorName']
                    ),
                itemCount: places.length,
              ),
            );
    } else if (index == 1) {
      returnedWidget = const Center(
        child: Text("Notification"),
      );
    } else {
      returnedWidget = Center(
        child: listOfPatient(ctx),
      );
    }

    return returnedWidget;
  }

  @override
  Widget build(BuildContext context) {
    Object? id = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        title: Container(
            child: Text(
          "hi, Dr. ${doctorInfo["name"]}",
          // style: TextStyle(color: Colors.black),
        )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorProfile(doctorinfo: doctorInfo);
              }));
            },
            icon: const Icon(
              Icons.person,
              // color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      drawer: DrawerWidget(
        userInfo: doctorInfo,
      ),
      body: SetBody(context),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: index,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                label: "message"),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createPost);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
