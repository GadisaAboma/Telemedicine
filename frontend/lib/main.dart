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
