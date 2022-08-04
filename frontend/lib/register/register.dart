import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/login/login.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;
  String password = "";
  String? gender;
  String specializedIn = "Conception and Pregnancy Adviser";

  String accountType = "patient";
  bool isDoctor = false;

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
    }
    Navigator.pop(context);
  }

  Widget bottomSheet() {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('Choose Image'),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                    label: const Text('Gallery'),
                    icon: const Icon(Icons.image)),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: const Text('Camera'),
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          )
        ],
      ),
    );
  }

  void register(BuildContext ctx) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        // isLoading = Provider.of<RegisterProvider>(context, listen: true).isLoading;
        loadingSpinner(ctx);
        final registerResponse =
            await Provider.of<RegisterProvider>(context, listen: false)
                .register(fullname, username, password, accountType,
                    specializedIn, gender.toString(), _image);
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
      }
    } catch (e) {
      Navigator.pop(ctx);
      showDialog(
          context: ctx,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(
                    width: 20,
                  ),
                  Text("info"),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"),
                )
              ],
              content: Text(e.toString()),
            );
          });
    }
  }

  Future loadingSpinner(BuildContext ctx) {
    return showDialog(
        context: (ctx),
        barrierDismissible: false,
        barrierLabel: "Loading......",
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              label: Text("Full Name"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              label: Text("Username"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))),
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
                                    items: const [
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
                                    }),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) => bottomSheet(),
                                      );
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Attach your id'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                _image == null
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Text('Image Preview'),
                                      )
                                    : Container(
                                        child: Image.file(_image!),
                                        height: 160,
                                      ),
                              ],
                            ),
                          ]),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              label: Text("Password"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))),
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
