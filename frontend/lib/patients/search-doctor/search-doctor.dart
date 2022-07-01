import 'package:flutter/material.dart';
import 'package:frontend/provider/patient.dart';
import 'package:provider/provider.dart';

class SearchDoctor extends StatefulWidget {
  SearchDoctor({Key? key}) : super(key: key);

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  TextEditingController edit = TextEditingController();

  String searchedDoctor = "";
  void search(BuildContext ctx) {
    searchedDoctor = edit.text;
    edit.text = "";
    Provider.of<PatientProvider>(context, listen: false)
        .searchDoctor(searchedDoctor);
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
                      decoration: InputDecoration(
                          hintText: "Search doctor",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () => search(context))
                ],
              )),
        ],
      ),
      body: Center(child: Text("search doctor")),
    );
  }
}
