import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/admin/admin_post.dart';
import 'package:frontend/admin/doctor_detail_info.dart';
import 'package:frontend/admin/doctors_request.dart';
import 'package:frontend/drawer/admin_drawer.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';
import '../posts/widgets/each_place.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../utils/helpers.dart';
import '../video chat/rtc/client_io.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isLoading = true;
  List posts = [];

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  int index = 0;

  var unApprovedDoctorsList;
  var loggedInUser;

  // @override
  // void initState() {
  //   // Provider.of<RegisterProvider>(context, listen: false).unApprovedDoctors();
  //   final loggedInUser =
  //       Provider.of<RegisterProvider>(context, listen: false).currentUser;
  //   super.initState();
  //   // print(loggedInUser["messages"][""]);
  // }

  Widget bodyWidget(BuildContext ctx) {
    Widget returnedwidget = Container();
    if (index == 1) {
      returnedwidget = DoctorsRequest();
    } else {
      returnedwidget = const AdminPost();
    }
    return returnedwidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Welcome Admin"),
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
      drawer: AdmminDrawer(),
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
