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
      body: doctor.isNotEmpty
          ? ListTile(
              leading: CircleAvatar(),
              title: Text(doctor['name'].toString()),
              subtitle: Text(doctor["specializedIn"].toString()),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {},
              ),
              onTap: () {},
            )
          : Center(child: Text("search doctor")),
    );
  }
}
