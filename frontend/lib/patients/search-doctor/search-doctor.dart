import 'dart:io';

import 'package:flutter/material.dart';

import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../../service/socket_service.dart';
import '../../views/chat/chat_page.dart';

class SearchDoctor extends StatefulWidget {
  SearchDoctor({Key? key}) : super(key: key);

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  TextEditingController edit = TextEditingController();

  String searchedDoctor = "";
  dynamic doctor = {};
  void search(BuildContext ctx) async {
    searchedDoctor = edit.text;
    edit.text = "";
    final returneddoctor =
        await Provider.of<PatientProvider>(context, listen: false)
            .searchDoctor(searchedDoctor);
    print(returneddoctor);
    if (returneddoctor != null) {
      setState(() {
        doctor = returneddoctor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: TextFormField(
                      controller: edit,
                      decoration: const InputDecoration(
                          hintText: "Search doctor",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () => search(context))
                ],
              )),
        ],
      ),
      body: doctor.isNotEmpty
          ? ListTile(
              leading: CircleAvatar(),
              title: Text(doctor['name'].toString()),
              subtitle: Text(doctor["specializedIn"].toString()),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  print(doctor["_id"]);
                  String logginUser =
                      Provider.of<RegisterProvider>(context, listen: false)
                          .loggedinUser;
                  SocketService.setUserName("chala");
                  SocketService.setReciever(doctor["username"]);
                  SocketService.setSender(logginUser);
                  SocketService.connectAndListen();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ));
                  // Navigator.pushNamed(context, chatPageRoute);
                },
              ),
              onTap: () {},
            )
          : Center(child: Text("search doctor")),
    );
  }
}
