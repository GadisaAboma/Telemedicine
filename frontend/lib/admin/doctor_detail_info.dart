import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';

class DoctorDetailInfo extends StatelessWidget {
  final doctorInfo;
  DoctorDetailInfo({this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctors detail")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: 200,
                child: Image.asset("assets/image/doctor.jpg")),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [Text("Name of doctor:  "), Text(doctorInfo["name"])],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Specialized in:  "),
                Text(doctorInfo["specializedIn"])
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Provider.of<RegisterProvider>(context, listen: false)
                          .approveRequest(doctorInfo["_id"]);
                    },
                    child: Text("Approve")),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Reject")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
