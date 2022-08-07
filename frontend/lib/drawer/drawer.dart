import 'package:flutter/material.dart';
import 'package:frontend/provider/message.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../doctor/doctor_profile.dart';

class DrawerWidget extends StatelessWidget {
  final userInfo;
  DrawerWidget({this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color.fromARGB(255, 8, 4, 4),
      child: Column(children: [
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DoctorProfile(doctorinfo: userInfo);
                      },
                    ));
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/image/doctor.jpg"),
                  ),
                ),
              ),
              ListTile(
                title: Text(userInfo["name"],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                // subtitle: Text(
                //   "phone number +251950488766",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Provider.of<RegisterProvider>(context, listen: false)
                        .loggedUserId !=
                    'admins'
                ? ListTile(
                    title: const Text(
                      "Appointments",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    leading: const Icon(Icons.event),
                    onTap: () {
                      // Provider.of<PreviousChat>(context, listen: false).dispose();
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, appointmentPage);
                    },
                  )
                : Container(),
            ListTile(
              title: const Text(
                "Edit Your Account",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: const Icon(Icons.edit),
              onTap: () async {
                Navigator.of(context).pushNamed(editAccount);
              },
            ),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: const Icon(Icons.logout),
              onTap: () async {
                // Provider.of<PreviousChat>(context, listen: false).dispose();
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                sharedPreferences.remove("username");
                sharedPreferences.remove("password");

                Navigator.pushReplacementNamed(context, loginRoute);
              },
            ),
          ],
        )
      ]),
    );
  }
}
