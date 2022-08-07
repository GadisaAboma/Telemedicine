import 'package:flutter/material.dart';
import 'package:frontend/provider/message.dart';

import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';

import '../../utils/helpers.dart';

class DoctorsList extends StatefulWidget {
  dynamic username;
  DoctorsList({this.username});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  dynamic user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        fetchPhysician();
      },
    );
  }

  bool isLoading = true;
  List? doctors;
  List? PhysiciansData;
  Future<void> fetchPhysician() async {
    user = await Provider.of<RegisterProvider>(context, listen: false)
        .fetchPhysician(widget.username);
    user["messages"].forEach((user) async {
      final pycn = await Provider.of<RegisterProvider>(context, listen: false)
          .fetchOnePhysician(widget.username);
      PhysiciansData!.add(pycn);
    });
    doctors = user["messages"].reversed.toList();
    setState(() {
      isLoading = false;
    });
  }

  Future fetchOnePhysician(String username) async {}
  Widget _listofDoctor(int index) {
    if (doctors!.length > 1 && index != doctors!.length - 1) {
      return Card(
        elevation: 5,
        child: InkWell(
          onTap: () async {
            await fetchPhysician();

            final chat = Provider.of<PreviousChat>(context, listen: false);

            (doctors?[index]["content"] as List).forEach((element) {
              (element as Map).remove("_id");
              chat.addToChatHistory(element);
            });

            chat.setUserName(widget.username);
            chat.setReciever(doctors?[index]["user"]);
            chat.setSender(widget.username);
            chat.connectAndListen(widget.username);

            Navigator.pushNamed(context, chatPageRoute, arguments: {
              "id": user["_id"],
              "username": doctors![index]["user"],
              "name": doctors![index]["user"]
            });
            setState(() {
              isLoading = false;
            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 5,
                    child: CircleAvatar(
                        radius: 5,
                        backgroundColor:
                            (Provider.of<PreviousChat>(context, listen: false)
                                    .contacts
                                    .any((element) => element
                                        .split(":")
                                        .contains(doctors![index]["user"]))
                                ? Colors.green
                                : Colors.yellow)),
                  ),
                ],
              ),
              title: Text(doctors?[index]["user"]),
              subtitle: Row(
                children: [
                  Text((Provider.of<PreviousChat>(context, listen: false)
                          .contacts
                          .any((element) => element
                              .split(":")
                              .contains(doctors![index]["user"]))
                      ? "online"
                      : "offline")),
                ],
              ),
              focusColor: Colors.blue,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PatientProvider>(context, listen: false).doctors();
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: MediaQuery.of(context).size.height * .9,
            child: doctors?.length == 1
                ? Center(
                    child: Text("No contacted doctor yet"),
                  )
                : ListView.builder(
                    itemCount: doctors?.length,
                    itemBuilder: (context, index) {
                      Widget listOfDoctor = Container();

                      return _listofDoctor(index);
                    }),
          );
  }
}
