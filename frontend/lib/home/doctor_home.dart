import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../chatbot/chatbot.dart';
import '../drawer/drawer.dart';
import '../posts/posts.dart';
import '../provider/register.dart';
import '../service/socket_service.dart';
import '../views/chat/chat_page.dart';

class DoctorHome extends StatefulWidget {
  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();
  int index = 0;
  dynamic doctorInfo;

  @override
  void initState() {
    doctorInfo =
        Provider.of<RegisterProvider>(context, listen: false).doctordInfo;

    // TODO: implement initState
    super.initState();
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

  Widget ListOfPatient(BuildContext ctx) {
    // String logginUser =
    //             Provider.of<RegisterProvider>(context, listen: false)
    //                 .loggedinUser;

    return ListView.builder(
        itemCount: doctorInfo["messages"].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doctorInfo["messages"][index]["user"]),
            leading: CircleAvatar(backgroundColor: Colors.amber),
            trailing: IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                // SocketService.setUserName(doctorInfo["username"]);
                SocketService.setReciever(
                    doctorInfo["messages"][index]["user"]);
                SocketService.setSender(doctorInfo["username"]);
                SocketService.connectAndListen(doctorInfo["username"]);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ChatPage(),
                ));
              },
            ),
          );
        });
  }

  Widget SetBody(BuildContext ctx) {
    Widget returnedWidget;
    if (index == 0) {
      returnedWidget = Center(
        child: ElevatedButton(
          child: Text("chatpage"),
          onPressed: () {
            print("object");

            // Navigator.pushNamed(context, chatPageRoute, arguments: id.toString());
          },
        ),
      );
    } else if (index == 1) {
      returnedWidget = Center(
        child: Text("Notification"),
      );
    } else {
      returnedWidget = Center(
        child: ListOfPatient(ctx),
      );
    }

    return returnedWidget;
  }

  @override
  Widget build(BuildContext context) {
    Object? id = ModalRoute.of(context)?.settings.arguments;
    // print(doctorInfo);

    return Scaffold(
      appBar: AppBar(
        title:
            Container(height: 40, child: Text("hi, Dr. ${doctorInfo["name"]}")),
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
      body: SetBody(context),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "message"),
          ]),
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
    );
  }
}
