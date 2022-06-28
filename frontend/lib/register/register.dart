import 'package:flutter/material.dart';
import 'package:frontend/login/login.dart';

class Register extends StatefulWidget {
  static String registerRoute = "/register";

  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  String name = "";
  String password = "";

  void register() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              margin: EdgeInsets.only(),
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: Text("login"),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Login.loginRoute);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Full Name")),
                    TextFormField(),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Username")),
                    TextFormField(),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Password")),
                    TextFormField(),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text("Register")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
