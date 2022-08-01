import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/register/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../video_call/utils/http_util.dart';
import '../video_call/utils/sotre_util.dart';
// import '../service/socket_service.dart';

class Login extends StatefulWidget {
  static String loginRoute = "/";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  FocusNode? focusNode;
  TextStyle textStyle() {
    return const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 4, 54, 146));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode?.dispose();
    super.dispose();
  }

  void login(BuildContext ctx) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loadingSpinner(ctx);

      //////////////////////////////////////////////////////
      /// FOR VIDEO CHAT
      // final data = await HttpUtil().login();
      // print('login: $data');

      ///////////////////////////////////////////////////////
      ///
      try {
        final loginResponse =
            await Provider.of<RegisterProvider>(ctx, listen: false)
                .login(username, password);
        // LocalStorage.write('userid', loginResponse["user"]["_id"]);
        // LocalStorage.write('username', username);
        switch (loginResponse['role']) {
          case "admin":
            Navigator.pushReplacementNamed(ctx, adminHomeRoute);
            break;
          case "doctor":
            Navigator.pushReplacementNamed(ctx, doctorHomeRoute,
                arguments: loginResponse["user"]["_id"]);

            break;
          case "patient":
            Navigator.pushReplacementNamed(ctx, patientHomeRoute);
            break;
          default:
            Navigator.pop(ctx);
        }
      } catch (e) {
        Navigator.pop(ctx);
        showDialog(
            context: ctx,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  children: [
                    const Icon(Icons.info),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("info"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Text("Ok")),
                  ),
                ],
                content: Text(e.toString()),
              );
            });
      }
    }
  }

  List<Color> _colors = [
    Color.fromARGB(199, 51, 105, 255),
    Color.fromARGB(101, 144, 203, 255),
    Color.fromARGB(131, 0, 204, 250)
  ];
  List<double> _stops = [0.0, 0.7];
  Future loadingSpinner(BuildContext ctx) {
    return showDialog(
        barrierDismissible: false,
        context: (ctx),
        builder: (ctx) {
          return AlertDialog(
            // alignment: Alignment.center,

            content: Container(
              height: 50,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.95,
            // height: 500,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    opacity: 0.9,
                    image: AssetImage("assets/image/back.jpg"),
                  )),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, registerRoute);
                          },
                          child: const Text(
                            "Register here!",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 233, 235, 238),
                                decorationStyle: TextDecorationStyle.dashed),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
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
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(37, 79, 79, 124),
                      gradient: LinearGradient(
                        colors: _colors,
                        begin: const FractionalOffset(0.0, 0.9),
                        end: const FractionalOffset(1.0, 0.0),
                        // stops: [0.0, 2.0],
                        // stops: [0.0, 0.6],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: const Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onTap: () {
                              print("helloo");
                            },
                            // focusNode: focusNode,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                label: const Text(
                                  "username",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0))),
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
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.lock),
                                  label: const Text(
                                    "password",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0))),
                              obscureText: true,
                              validator: ((value) {
                                String password = value.toString().trim();
                                if (password.isEmpty) {
                                  return "password field required";
                                }
                                if (password.length < 3) {
                                  return "password must greater than 3 character";
                                }
                              }),
                              onSaved: (value) {
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
    );
  }
}
