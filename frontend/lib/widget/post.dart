import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 10,
        ),
        margin: EdgeInsets.only(
          top: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
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
              title: Container(
                margin: EdgeInsets.all(6),
                child: Text(
                  "Dr. Getch Sileshi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              subtitle: Text("Doktora waa'eee fayya daa'immani barsisu"),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Text(
                  "Dhukkuboota daa'immani keessa kan baay'ee balafamaa ta'e isa daa'imoonni rafanii achiin hafanidha. dhukkubni kun kan daa'imman qabatuuf isaa maatiin daa'ima isaani yaadachuu dhabuu irraa yoo ka'udha."),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              // color: Color.fromARGB(255, 191, 195, 206),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 40,
                      width: 120,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 229, 235, 243),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).primaryColor,
                          ))),
                  Container(
                    width: 120,
                    height: 40,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 229, 235, 243),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
