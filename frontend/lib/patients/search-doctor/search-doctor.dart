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
  String physicianCategory = "Conception and Pregnancy Adviser";
  List physicians = [];
  bool isLoading = false;
  void search(BuildContext ctx) async {
    // searchedDoctor = edit.text;

    // edit.text = "";
    setState(() {
      isLoading = true;
    });
    try {
      final returneddoctor =
          await Provider.of<PatientProvider>(context, listen: false)
              .searchDoctor(physicianCategory);
      setState(() {
        isLoading = false;
      });
      if (returneddoctor != null) {
        setState(() {
          physicians = returneddoctor;
          print(physicians);
        });
      }
    } catch (e) {
      //  Navigator.pop(context);
      print(e);
    }
  }
//

  var items = [
    "Conception and Pregnancy Adviser",
    "Critical Infant Caregiver",
    "Premature and Newborn Supervisor",
    "Routine Check-Up Expert"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Container(
        //   height: 40,
        //   margin: EdgeInsets.all(5),
        //   decoration: BoxDecoration(
        //     // color: Colors.white,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Row(
        //     children: [
        // Container(
        //   width: 166,
        //   child: TextFormField(
        //     controller: edit,
        //     decoration: const InputDecoration(
        //         hintText: "Search doctor",
        //         border: OutlineInputBorder(
        //           borderSide: BorderSide.none,
        //         )),
        //   ),
        // ),
        // ],

        title: Text("Search doctor"),
        
      
      ),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//               color: Colors.green,
//             ))
//           : doctor == "doctor not found"
//               ? Center(
//                   child: Text(doctor),
//                 )
//               : doctor.isNotEmpty && doctor['name'] != null
//                   ? ListTile(
//                       leading: CircleAvatar(),
//                       title: Text(doctor['name'].toString()),
//                       subtitle: Text(doctor["specializedIn"].toString()),
//                       trailing: IconButton(
//                         icon: Icon(Icons.message),
//                         onPressed: () async {
//                           // print(doctor["_id"]);

//                           final provider = Provider.of<RegisterProvider>(
//                               context,
//                               listen: false);
//                           final chat =
//                               Provider.of<PreviousChat>(context, listen: false);
//                           String myUsername = provider.currentUser["username"];
//                           final patientData =
//                               await provider.fetchMessage(myUsername);

//                           // String myUsername = provider.me;
//                           // final patientData = await provider.fetchPatient(myUsername);
//                           // Map<String, String> data = json.decode(patientData);
// // (patientData["messages"]["content"] as List)
// //                         .forEach((data) {
// //                       (data as Map).remove("_id");
// //                       print(data);
// //                       chat.addToChatHistory(data);
// //                     });

//                           print(patientData);
//                           (patientData["messages"] as List).forEach((element) {
//                             if (element["user"] == doctor["username"]) {
//                               (element["content"] as List).forEach((message) {
//                                 (message as Map).remove("_id");
//                                 print(patientData["messages"]);
//                                 chat.addToChatHistory(message);
//                               });
//                             }
//                           });

//                           chat.setUserName(myUsername);
//                           chat.setReciever(doctor["username"]);
//                           chat.setSender(myUsername);
//                           chat.connectAndListen(myUsername);

//                           Navigator.pushNamed(context, chatPageRoute,
//                               arguments: {
//                                 "id": doctor["_id"],
//                                 "name": doctor["name"],
//                                 "username": doctor["username"]
//                               });
//                         },
//                       ),
//                       onTap: () {},
//                     )
//                   : Center(child: Text("search doctor")),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          // width: 300,
          margin: EdgeInsets.only(left: 30, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                // Initial Value
                value: physicianCategory, elevation: 5,
                dropdownColor: Colors.white,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                borderRadius: BorderRadius.circular(10),

                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                ),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    physicianCategory = newValue!;
                    search(context);
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onPressed: () => search(context)),
            ],
          ),
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.green,
              ))
            : physicians.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: physicians
                          .map((physician) => Card(
                                elevation: 10,
                                child: ListTile(
                                  leading: CircleAvatar(),
                                  title: Text(physician['name'].toString()),
                                  subtitle: Text(
                                      physician["specializedIn"].toString()),
                                  trailing: IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () async {
                                      // print(doctor["_id"]);

                                      final provider =
                                          Provider.of<RegisterProvider>(context,
                                              listen: false);
                                      final chat = Provider.of<PreviousChat>(
                                          context,
                                          listen: false);
                                      String myUsername =
                                          provider.currentUser["username"];
                                      final patientData = await provider
                                          .fetchMessage(myUsername);

                                      // String myUsername = provider.me;
                                      // final patientData = await provider.fetchPatient(myUsername);
                                      // Map<String, String> data = json.decode(patientData);
                                      // (patientData["messages"]["content"] as List)
                                      //                         .forEach((data) {
                                      //                       (data as Map).remove("_id");
                                      //                       print(data);
                                      //                       chat.addToChatHistory(data);
                                      //                     });

                                      print(patientData);
                                      (patientData["messages"] as List)
                                          .forEach((element) {
                                        if (element["user"] ==
                                            physician["username"]) {
                                          (element["content"] as List)
                                              .forEach((message) {
                                            (message as Map).remove("_id");
                                            print(patientData["messages"]);
                                            chat.addToChatHistory(message);
                                          });
                                        }
                                      });

                                      chat.setUserName(myUsername);
                                      chat.setReciever(physician["username"]);
                                      chat.setSender(myUsername);
                                      chat.connectAndListen(myUsername);

                                      Navigator.pushNamed(
                                          context, chatPageRoute,
                                          arguments: {
                                            "id": physician["_id"],
                                            "name": physician["name"],
                                            "username": physician["username"]
                                          });
                                    },
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Text("no physician found")
      ]),
    );
  }
}
