import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title:Text( "Abib Ali"),
          subtitle: Text("abibi ali set appointement to june 14 2022"),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/image/doctor.jpg"),
          ),
        ),
        Divider()
      ],
    );
  }
}
