import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 200,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/image/doctor.jpg"),
                ),
              ),
              ListTile(
                title: Text("Abib Ali"),
                subtitle: Text("phone number +251950488766"),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
