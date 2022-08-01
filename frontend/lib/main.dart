import 'package:flutter/material.dart';
import 'package:frontend/appointment/appointment_home.dart';
import 'package:frontend/appointment/set_appointment.dart';
// import 'package:frontend/chat-page/chatpage.dart';
import 'package:frontend/home/admin_home.dart';
import 'package:frontend/home/doctor_home.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/patients/search-doctor/search-doctor.dart';
import 'package:frontend/provider/message.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/register/register.dart';
import 'package:frontend/views/chat/chat_page.dart';
import 'package:provider/provider.dart';

import 'home/patient_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => RegisterProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => PatientProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => PreviousChat()),
        ),
        // ChangeNotifierProvider(
        //   create: ((context) => SocketService()),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Color.fromARGB(198, 7, 21, 97),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(199, 4, 14, 26),
          ),
        ),

        //         static String patientHomeRoute = "/PatientHome";
        // static String doctorHomeRoute = "/doctorHome";
        // static String adminHomeRoute = "/adminHome";
        // static String loginRoute = "/";
        // static String registerRoute = "/register";
        routes: {
          '/': (context) => Login(),
          "/register": (context) => Register(),
          "/PatientHome": (context) => PatientHome(),
          "/doctorHome": (context) => DoctorHome(),
          "/adminHome": (context) => AdminHome(),
          "/searchDoctor": (context) => SearchDoctor(),
          "/chatPage": (context) => ChatPage(),
          "/appointment": (context) => AppointmentHome(),
          "/setAppointment": (context) => SetAppointment()
          
        },
        // home: Login(),
      ),
    );
  }
}
