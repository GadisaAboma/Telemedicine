import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  final doctorinfo;
  const DoctorProfile({this.doctorinfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctorinfo["name"])),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/image/doctor.jpg"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(
              Icons.perm_identity,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Full name: "),
            SizedBox(
              width: 10,
            ),
            Text(doctorinfo["name"])
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // if (doctorinfo.contains("spacializedIn"))
        //   Row(
        //     children: [
        //       Icon(
        //         Icons.book,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Text("spacializedIn: "),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Text(doctorinfo["specializedIn"])
        //     ],
        //   ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(
              Icons.g_mobiledata,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Gender: "),
            SizedBox(
              width: 10,
            ),
            Text(doctorinfo["gender"])
          ],
        ),
      ]),
    );
  }
}
