import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                                padding: const EdgeInsets.all(25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointments[index]['description'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
              //                             DateFormat.yMMMEd() 
              // .format(DateTime.parse(appointments[index]['date'])
              appointments[index]['date']
              , 
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(Icons.delete),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: appointments.length,
                      ),
                    ),
                  )

        /* Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.search,
                      color: Color(MyColors.purple02),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: ((value) => username = value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a patient',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color(MyColors.purple01),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                    });
                    _searchDoctor(context);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
              ),
            ),
            patient.isNotEmpty
                ? GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(setAppointment,
                        arguments: {
                          'id': patient['_id'],
                          'name': patient['name']
                        }),
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/image/doctor.jpg"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient['name'],
                                      style: TextStyle(
                                        color: Color(MyColors.header01),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "patient",
                                      style: TextStyle(
                                        color: Color(MyColors.grey02),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Text("No patient found"),
          ],
        ), */
        );
    return widget.home != "yes"
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Appointments"),
              actions: [
                loggedType == 'doctors'
                    ? IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, selectUser);
                        },
                        icon: const Icon(Icons.add))
                    : Container()
              ],
            ),
            body: body)
        : body;
  }
}
