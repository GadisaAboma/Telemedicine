import 'package:flutter/material.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/register/register.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color.fromARGB(199, 4, 14, 26),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(199, 4, 14, 26),
=======
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:((context) =>  RegisterProvider()),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: const Color.fromARGB(199, 4, 14, 26),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(199, 4, 14, 26),
          ),
>>>>>>> 844ff799ddc66c079aa0f29bc4c1c0de7271e485
        ),
        routes: {
          '/':(context)=>Login(),
          "/register":(context) => Register(),
          // "/adminHome":(context) => 
        },
        // home: Login(),
      ),
    );
  }
}
