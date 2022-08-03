import 'package:flutter/material.dart';
import 'package:frontend/provider/message.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
import '../provider/register.dart';

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
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/image/doctor.jpg"),
                  ),
                ),
                
              ),
              ListTile(
                title: Text(Provider.of<RegisterProvider>(context, listen: false).loggedName, style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  "phone number +251950488766",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            
            ListTile(
              title: Text("Appointment"),
              leading: Icon(Icons.event),
              onTap: () {
                // Provider.of<PreviousChat>(context, listen: false).dispose();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, appointmentPage);
              },
            ),
            ListTile(
              title: Text("logout"),
              leading: Icon(Icons.logout),
              onTap: () {
                // Provider.of<PreviousChat>(context, listen: false).dispose();
                Navigator.pushReplacementNamed(context, loginRoute);
              },
            ),
          ],
        )
      ]),
    );
  }
}
