

import 'package:flutter/material.dart';
import 'package:frontend/forgot%20password/reset_password.dart';

class ConfirmSecretCode extends StatelessWidget {
  int secretCode;
  String email;
  ConfirmSecretCode({required this.secretCode, required this.email});

  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  void confirmSecretCode(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ResetPassword(email: email);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm identity")),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: [
            Text(
              "Write the code you recieved from babycare telemedicine",
              softWrap: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                String newValue = value!.trim();
                print(secretCode);
                if (newValue.isEmpty) {
                  return "please enter secret code";
                } else if (int.parse(newValue) != secretCode) {
                  return "it is not valid secret code";
                }
              },
              decoration: InputDecoration(
                labelText: "confirm secret code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                confirmSecretCode(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Text("Confirm email"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
