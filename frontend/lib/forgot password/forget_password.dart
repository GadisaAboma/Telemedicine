import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/forgot%20password/confirm_secretcode.dart';
import 'package:frontend/provider/register.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int secretCode = 0;

  void checkSecretcode() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget password"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Write your valid email to forget your password",
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        String newValue = value.toString().trim();
                        final bool isValid = EmailValidator.validate(newValue);
                        if (newValue.isEmpty) {
                          return "please enter eamil";
                        } else if (!isValid) {
                          return "invalid email";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                            email = controller.text;
                            secretCode = Random().nextInt(9000) + 1000;
                          });
                          try {
                            final response =
                                await Provider.of<RegisterProvider>(context,
                                        listen: false)
                                    .forgotPassword(secretCode, email);
                            print(response);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ConfirmSecretCode(
                                  secretCode: secretCode, email: email);
                            }));
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(Icons.warning),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(" Invalid email")
                                      ],
                                    ),
                                    content:Text(
                                          e.toString(),
                                          softWrap: true,
                                        ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("ok"))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Text("Verify Email"),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
