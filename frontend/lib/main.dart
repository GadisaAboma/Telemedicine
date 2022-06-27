import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(199, 4, 14, 26),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(199, 4, 14, 26),
        ),
      ),
      home: Home(),
    );
  }
}
