import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/provider/doctor.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:intl/intl.dart';
import '../provider/register.dart';
import './styles/styles.dart';
import './styles/colors.dart';
import '../utils/helpers.dart';
import 'package:provider/provider.dart';

class AppointmentHome extends StatefulWidget {
  String? home;
  AppointmentHome({this.home});

  @override
  State<AppointmentHome> createState() => _AppointmentHomeState();
}

class _AppointmentHomeState extends State<AppointmentHome> {
  bool isLoading = true;
  bool isDeleting = false;
  List<dynamic> appointments = [];

  var loggedType;
  var loggedId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchAppointments();
    });
  }

  void fetchAppointments() async {
    loggedId =
        Provider.of<RegisterProvider>(context, listen: false).loggedUserId;
    loggedType =
        Provider.of<RegisterProvider>(context, listen: false).loggedUserType;

    appointments = await Provider.of<PatientProvider>(context, listen: false)
        .fetchAppointment(loggedId, loggedType);

    setState(() {
      isLoading = false;
    });
  }

  void deleteAppointment(String id, patientId, doctorId) async {
    setState(() {
      isDeleting = true;
    });
    var userType =
        Provider.of<RegisterProvider>(context, listen: false).loggedUserType;
    await Provider.of<DoctorProvider>(context, listen: false)
        .deleteAppointment(id, patientId, doctorId, userType);
    setState(() {
      isDeleting = false;
    });
    fetchAppointments();
  }

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget body = SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : appointments.isEmpty
                ? const Center(
                    child: Text(
                      "Empty Appointment",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        appointmentDetail,
                                        arguments: {
                                          "description": appointments[index]
                                              ['description'],
                                          "date": appointments[index]['date'],
                                          "doctorName": appointments[index]
                                              ['doctorName'],
                                          "patientName": appointments[index]
                                              ['patientName'],
                                        });
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     Navigator.of(context).pushNamed(
                                          //         appointmentDetail,
                                          //         arguments: {
                                          //           "description":
                                          //               appointments[index]
                                          //                   ['description'],
                                          //           "date": appointments[index]
                                          //               ['date']
                                          //         });
                                          //   },
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Text(
                                              appointments[index]
                                                  ['description'],
                                              softWrap: true,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            //                             DateFormat.yMMMEd()
                                            // .format(DateTime.parse(appointments[index]['date'])
                                            appointments[index]['date'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      isDeleting
                                          ? const CircularProgressIndicator()
                                          : IconButton(
                                              onPressed: () {
                                                deleteAppointment(
                                                  appointments[index]['_id'],
                                                  appointments[index]
                                                      ['patientId'],
                                                  appointments[index]
                                                      ['doctorId'],
                                                );
                                              },
                                              icon: const Icon(Icons.cancel),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: appointments.length,
                      ),
                    ),
                  ));
    return widget.home != "yes"
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Appointments"),
              actions: [
                loggedType == 'doctors'
                    ? IconButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, selectUser);

                          if (true) {
                            fetchAppointments();
                          }
                        },
                        icon: const Icon(Icons.add))
                    : Container()
              ],
            ),
            body: body)
        : body;
  }
}
