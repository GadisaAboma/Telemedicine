import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/provider/doctor.dart';
import 'package:frontend/utils/helpers.dart';
import '../appointment/styles/colors.dart';
import 'package:provider/provider.dart';

import '../provider/register.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  var password;
  bool isLoading = false;

  void confirmPassword() async {
    if (password == null) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    var loggedId =
        Provider.of<RegisterProvider>(context, listen: false).loggedId;
    var type =
        Provider.of<RegisterProvider>(context, listen: false).loggedUserType;
    var isConfirmed = await Provider.of<DoctorProvider>(context, listen: false)
        .verifyUserIdentity(loggedId, password, type);

    setState(() {
      isLoading = false;
    });

    if (isConfirmed == "success") {
      Navigator.of(context).pushNamed(editPage);
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "Incorrect password, please try correcting your password"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("ok"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your identity"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            onChanged: ((value) => password = value),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter previous password',
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(MyColors.purple01),
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      confirmPassword();
                    },
                    child: const Text("confirm"),
                  ),
                )
        ]),
      ),
    );
  }
}
