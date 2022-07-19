import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/provider/message.dart';

import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
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
    // print(returneddoctor);
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
        title: Container(
          width: 300,
          height: 40,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
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
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: doctor.isNotEmpty
          ? ListTile(
              leading: CircleAvatar(),
              title: Text(doctor['name'].toString()),
              subtitle: Text(doctor["specializedIn"].toString()),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () async {
                  // print(doctor["_id"]);

                  final provider =
                      Provider.of<RegisterProvider>(context, listen: false);
                  final chat =
                      Provider.of<PreviousChat>(context, listen: false);
                  String myUsername = provider.me;
                  final patientData = await provider.fetchMessage(myUsername);

                  (patientData["messages"] as List).forEach((element) {
                    if (element["user"] == doctor["username"]) {
                      (element["content"] as List).forEach((message) {
                        (message as Map).remove("_id");
                        print(patientData["messages"]);
                        chat.addToChatHistory(message);
                      });
                    }
                  });

                  // print(patientData["messages"]);

                  chat.setUserName(myUsername);
                  chat.setReciever(doctor["username"]);
                  chat.setSender(myUsername);
                  chat.connectAndListen(myUsername);

                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) =>  ChatPage(),
                  // ));
                  Navigator.pushNamed(context, chatPageRoute);
                },
              ),
              onTap: () {},
            )
          : Center(child: Text("search doctor")),
    );
  }
}
