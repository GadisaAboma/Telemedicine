import 'dart:io';

import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'create_place.dart';
import '../widgets/my_places.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _index = 0;

  File? _image;

  Widget bottomSheet() {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('Choose Image'),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextButton.icon(
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                    label: const Text('Gallery'),
                    icon: const Icon(Icons.image)),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: const Text('Camera'),
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
    }
    Navigator.pop(context);

    if (_image != null) {
      Provider.of<Users>(context, listen: false).changeProfile(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String loggedUser = Provider.of<Auth>(context, listen: false).loggedUser;

    Widget currentTab = Container();

    switch (_index) {
      case 0:
        break;
      case 1:
        currentTab = const MyPlaces();
        break;
      case 2:
        currentTab = const CreatePost();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text('Profile'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*  CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage("assets/gado.jpg")), */
                  Stack(
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage('assets/gado.jpg'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.file(
                                _image!,
                                height: 150.0,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          color: Colors.black87,
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => bottomSheet(),
                            );
                          },
                          iconSize: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loggedUser,
                  style: const TextStyle(
                      fontFamily: 'QuickSand',
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: currentTab,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => setState(() {
          _index = index;
        }),
        selectedItemColor: Colors.grey,
        unselectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Liked Places'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'My Places'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Place'),
        ],
      ),
    );
  }
}
