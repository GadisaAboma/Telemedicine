import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatelessWidget {
  DoctorList({Key? key});


  var doctors;

  @override
  Widget build(BuildContext context) {
    doctors = Provider.of<RegisterProvider>(context, listen: false).chattedDoctor;
    print(doctors);
    return Container(
      child: Center(child: Text("chat")),
    );
  }
}
