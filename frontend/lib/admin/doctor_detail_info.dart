import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

class DoctorDetailInfo extends StatefulWidget {
  final doctorInfo;
  DoctorDetailInfo({this.doctorInfo});

  @override
  State<DoctorDetailInfo> createState() => _DoctorDetailInfoState();
}

class _DoctorDetailInfoState extends State<DoctorDetailInfo> {
  bool isLoading = false;

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
                child: Image.network(
                    '$serverUrl/${widget.doctorInfo['idUrl'].toString().replaceAll('\\', '/')}')),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Name of doctor:  "),
                Text(
                  widget.doctorInfo["name"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Specialized in:  "),
                Text(widget.doctorInfo["specializedIn"])
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      AlertDialog(
                        content: isLoading
                            ? CircularProgressIndicator()
                            : Text("Request Approved"),
                        actions: [
                          !isLoading
                              ? TextButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Text("success"))
                              : Text("Loading")
                        ],
                      );
                      setState(() {
                        isLoading = true;
                      });
                      Provider.of<RegisterProvider>(context, listen: false)
                          .approveDoctor(widget.doctorInfo["_id"]);
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
