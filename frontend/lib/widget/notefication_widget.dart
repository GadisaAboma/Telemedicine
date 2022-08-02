import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: const [
          ListTile(
            title:Text( "Abib Ali"),
            subtitle: Text("abibi ali set appointement to june 14 2022"),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/image/doctor.jpg"),
            ),
          ),
          Divider(height: 5,)
        ],
      ),
    );
  }
}
