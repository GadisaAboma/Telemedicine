import 'package:flutter/material.dart';

import 'package:frontend/provider/patient.dart';
import 'package:provider/provider.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PatientProvider>(context, listen: false).doctors();
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("doctors"),
              focusColor: Colors.blue,
            );
          }),
    );
  }
}
