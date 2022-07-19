import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  late bool isLoading;
  String fullname = "";
  String username = "";
  String password = "";
  String? gender;
  String specializedIn = "Conception and Pregnancy Adviser";

  String accountType = "patient";
  bool isDoctor = false;

  void register(BuildContext ctx) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // isLoading = Provider.of<RegisterProvider>(context, listen: true).isLoading;
      loadingSpinner(ctx);
      final registerResponse =
          await Provider.of<RegisterProvider>(context, listen: false).register(
              fullname,
              username,
              password,
              accountType,
              specializedIn,
              gender.toString());
      print("registerResponse: $registerResponse");
      if (registerResponse == "success" && accountType == "patient") {
        // Navigator.pop(ctx);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, patientHomeRoute);
      }
      if (registerResponse == "success" && accountType == "doctor") {
        // Navigator.pop(ctx);
        Navigator.pushReplacementNamed(context, doctorHomeRoute);
      }
      // Navigator.pop(ctx);
    }
  }

  Future loadingSpinner(BuildContext ctx) {
    return showDialog(
        context: (ctx),
        builder: (ctx) {
          return AlertDialog(
            // alignment: Alignment.center,
            content: Container(
                height: 50, child: Center(child: CircularProgressIndicator())),
            // actions: [Container(child: CircularProgressIndicator())],
          );
        });
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "doctor", child: Text("Doctor")),
      const DropdownMenuItem(value: "patient", child: Text("Patient")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                margin: EdgeInsets.only(),
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: SingleChildScrollView(
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
                            child: Row(children: [
                          Text("who are you?"),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                              value: accountType,
                              items: dropdownItems,
                              onChanged: (values) {
                                setState(() {
                                  accountType = values.toString();
                                  if (accountType == "doctor") {
                                    isDoctor = true;
                                  } else {
                                    isDoctor = false;
                                  }
                                });
                                print(accountType);
                              }),
                        ])),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text("Full Name")),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: ((value) {
                            String fullname = value.toString().trim();
                            if (fullname.isEmpty) {
                              return "fullname does not empty";
                            }
                            if (fullname.length < 5) {
                              return "full name must greater than 5 character";
                            }
                          }),
                          onSaved: (value) {
                            setState(() {
                              fullname = value.toString();
                            });
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Text("gender"),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        // DropdownButton(
                        //     iconEnabledColor: Colors.amber,
                        //     value: gender,
                        //     items: [
                        //       DropdownMenuItem(
                        //         child: Text("male"),
                        //         value: "male",
                        //       ),
                        //       DropdownMenuItem(
                        //         value: "female",
                        //         child: Text("Female"),
                        //       ),
                        //     ],
                        //     onChanged: (value) {
                        //       setState(() {
                        //         gender = value.toString();
                        //       });
                        //     }),

                        //   ],
                        // ),

                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text("Username")),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: ((value) {
                            String username = value.toString().trim();
                            if (username.isEmpty) {
                              return "username does not empty";
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
                          height: 30,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("What is your gender?"),
                              ListTile(
                                title: Text("Male"),
                                leading: Radio(
                                    value: "male",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                              ),
                              ListTile(
                                title: Text("Female"),
                                leading: Radio(
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                              )
                            ]),
                        if (isDoctor)
                          Column(children: [
                            Row(
                              children: [
                                Text("Specialized in"),
                                SizedBox(
                                  width: 20,
                                ),
                                DropdownButton(
                                    value: specializedIn,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                            "Conception and Pregnancy Adviser"),
                                        value:
                                            "Conception and Pregnancy Adviser",
                                      ),
                                      DropdownMenuItem(
                                        child:
                                            Text("Critical Infant Caregiver"),
                                        value: "Critical Infant Caregiver",
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                            "Premature and Newborn Supervisor"),
                                        value:
                                            "Premature and Newborn Supervisor",
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Routine Check-Up Expert"),
                                        value: "Routine Check-Up Expert",
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        specializedIn = value.toString();
                                      });
                                    })
                              ],
                            ),
                          ]),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text("Password")),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: ((value) {
                            String password = value.toString().trim();
                            if (password.isEmpty) {
                              return "password does not empty";
                            }
                            if (password.length < 7) {
                              return "password must greater than 7 character";
                            }
                          }),
                          onSaved: (value) {
                            setState(() {
                              password = value.toString();
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => register(context),
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
        ),
      ),
    );
  }
}
