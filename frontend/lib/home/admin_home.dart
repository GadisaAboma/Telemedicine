import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/admin/doctor_detail_info.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';

import "../video_call/rtc/client_io.dart";
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
  var unApprovedDoctorsList;

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).unApprovedDoctors();
    final loggedInUser =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    ClientIO().init(loggedInUser["_id"], loggedInUser["username"]);

    ClientIO().rootContext = context;
    super.initState();
  }

  Widget bodyWidget(BuildContext ctx) {
    Widget returnedwidget = Container();
    if (index == 1) {
      unApprovedDoctorsList = Provider.of<RegisterProvider>(ctx, listen: true)
          .unApprovedDoctorsList;
      print(unApprovedDoctorsList);
      return unApprovedDoctorsList[0] == null
          ? returnedwidget = Center(
              child: Text("There is unapproved doctors"),
            )
          : ListView.builder(
              itemCount: unApprovedDoctorsList.length,
              itemBuilder: ((_, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(unApprovedDoctorsList[index]["name"]),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DoctorDetailInfo(
                              doctorInfo: unApprovedDoctorsList[index]);
                        }));
                      },
                    ),
                    Divider()
                  ],
                );
              }),
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
        elevation: 0,
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
      body: bodyWidget(context),
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
