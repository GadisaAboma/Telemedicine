import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  String email;

  ResetPassword({required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String password;
  late String confirmPassword;
  late String checker1;
  late String checker2;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  void submitPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        final respond =
            await Provider.of<RegisterProvider>(context, listen: false)
                .resetPassord(widget.email, password);
        setState(() {
          isLoading = false;
        });
        // Navigator.pop(context);
        print("respond " + respond);
        if (respond == "success") {
          // Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, loginRoute);
                        },
                        child: Text("ok"))
                  ],
                  content: Text("click ok to signin"),
                  title: Text("successfully resetted"),
                );
              });
        }
      } catch (e) {
        Navigator.pop(context);
        print("error occur " + e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set new password")),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: [
            Text(
              "Write new password",
              softWrap: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                checker1 = value!.trim();
                if (checker1.isEmpty) {
                  return "please enter password";
                } else if (checker1.length < 7) {
                  return "passord must be greater than or equal to 8 character";
                }
              },
              onSaved: (value) {
                setState(() {
                  password = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: "new password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                checker2 = value!.trim();
                if (checker2.isEmpty) {
                  return "please enter secret code";
                } else if (checker2.length < 7) {
                  return "passord must be greater than or equal to 8 character";
                } else if (!identical(checker1, checker1)) {
                  return "password doesnot match";
                }
              },
              onSaved: (value) {
                setState(() {
                  confirmPassword = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: "confirm password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isLoading ? null : submitPassword,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text("reset password"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
