import 'package:flutter/material.dart';
import 'package:frontend/home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextStyle textStyle() {
  return TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Register here!",
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.dashed),
                      )),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(19, 14, 14, 15),
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
                      Text("Username"),
                      TextFormField(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Password"),
                      TextFormField(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          },
                          child: Text("login"),
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Forget password"),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
