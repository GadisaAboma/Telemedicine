import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
import './styles/styles.dart';
import './styles/colors.dart';
import 'package:intl/intl.dart';

class SetAppointment extends StatefulWidget {
  const SetAppointment({Key? key}) : super(key: key);

  @override
  State<SetAppointment> createState() => _SetAppointmentState();
}

class _SetAppointmentState extends State<SetAppointment> {

  var date;
  var appointments;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    var id = args['id'];
    var description = "";

    void setAppointmentDate() async {
      appointments = await Provider.of<PatientProvider>(listen: false, context)
          .setAppointment(id, date.toString(), description);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("calander will appear here"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text(
                    "Selected Patient",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    args['name'],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ]),
              ),
              const SizedBox(height: 40),
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
                        Icons.description,
                        color: Color(MyColors.purple02),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) => description = value,
                        minLines: 2,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Appointment description',
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
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                child: Text(
                  date == null ? "No date choosen" : date.toString(),
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(MyColors.bg03),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                  onDateChanged: (selectedDate) {
                    setState(() {
                      date = selectedDate;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: double.infinity,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: setAppointmentDate,
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),

                    // style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
