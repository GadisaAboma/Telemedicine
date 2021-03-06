import 'package:flutter/material.dart';
import 'package:frontend/appointment/appointment_home.dart';
import 'package:frontend/appointment/select_user.dart';
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
import 'package:provider/provider.dart';
import './posts/pages/create_place.dart';

import 'home/patient_home.dart';
import 'views/chat/chat_page.dart';

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
        title: 'Telemedicine application',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Color.fromARGB(197, 6, 57, 116),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(197, 6, 57, 116),
          ),
        ),

        routes: {
          '/': (context) => Login(),
          "/register": (context) => Register(),
          "/PatientHome": (context) => PatientHome(),
          "/doctorHome": (context) => DoctorHome(),
          "/adminHome": (context) => AdminHome(),
          "/searchDoctor": (context) => SearchDoctor(),
          "/chatPage": (context) => ChatPage(),
          "/appointment": (context) => AppointmentHome(),
          "/setAppointment": (context) => SetAppointment(),
          "/selectUser": (context) => SelectUser(),
          "/createPost": (context) => CreatePost(),
          
        },
        // home: Login(),
      ),
    );
  }
}
