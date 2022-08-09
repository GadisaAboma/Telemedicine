import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentDetail();

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  var description;
  var date;
  var doctorName;
  var patientName;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    description = args['description'];
    date = args['date'];
    doctorName = args['doctorName'];
    patientName = args['patientName'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment detail"),
      ),
      body: Card(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    Container(
                      width: 200,
                      child: Text(description,
                      softWrap: true,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Text("Set by",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                    Text(doctorName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Text("Set to",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                    Text(patientName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Text("Date",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                    Text(
                        DateFormat.yMMMEd()
                            .format(DateTime.parse(date))
                            .toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Text("Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                    Text(
                        (DateTime.parse(date)
                                    .difference(DateTime.now())
                                    .inMicroseconds) >
                                0
                            ? "Pending"
                            : "Passed",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
