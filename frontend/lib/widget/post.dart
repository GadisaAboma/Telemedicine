import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/image/doctor.jpg"),
              ),
              title: Text(
                "Dr. Getch Sileshi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text("Doktora waa'eee fayya daa'immani barsisu"),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                  "Dhukkuboota daa'immani keessa kan baay'ee balafamaa ta'e isa daa'imoonni rafanii achiin hafanidha. dhukkubni kun kan daa'imman qabatuuf isaa maatiin daa'ima isaani yaadachuu dhabuu irraa yoo ka'udha."),
            ),
          ],
        ));
  }
}
