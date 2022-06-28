import 'package:flutter/material.dart';
import 'package:frontend/home/home.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/register/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String loginRoute = "/";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextStyle textStyle() {
  return TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  void login(BuildContext ctx) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final responseLogin =
          await Provider.of<RegisterProvider>(context, listen: false)
              .login(username, password);
      print(responseLogin);
      if (responseLogin['code'] == 404) {
        print(responseLogin["error"]);
      } else if (responseLogin["code"] == 202) {
        Navigator.pushReplacementNamed(context, Helpers.homeRoute);
      }
    }
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Helpers.registerRoute);
                        },
                        child: Text(
                          "Register here!",
                          style: TextStyle(
                              decorationStyle: TextDecorationStyle.dashed),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello,",
                            style: textStyle(),
                          ),
                          Text(
                            "Welcome To",
                            style: textStyle(),
                          ),
                          Text(
                            "Telemedicine",
                            style: textStyle(),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(19, 7, 7, 185),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Username"),
                            TextFormField(
                              validator: ((value) {
                                String username = value.toString().trim();
                                if (username.isEmpty) {
                                  return "username field required";
                                }
                                if (username.length < 3) {
                                  return "username must greater than 3 character";
                                }
                              }),
                              onSaved: (value) {
                                setState(() {
                                  username = value.toString();
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Password"),
                            TextFormField(validator: ((value) {
                              String password = value.toString().trim();
                              if (password.isEmpty) {
                                return "password field required";
                              }
                              if (password.length < 3) {
                                return "password must greater than 3 character";
                              }
                            }), onSaved: (value) {
                              setState(() {
                                password = value.toString();
                              });
                            }),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[900],
                                  textStyle: const TextStyle(fontSize: 22),
                                ),
                                onPressed: () => login(context),
                                label: const Text("login"),
                                icon: const Icon(Icons.login),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text("Forget password"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
