import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/users.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _form = GlobalKey<FormState>();
  File? _image;
  var name, description;
  var isLoading = false;

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
  }

  Future<void> createPlaceHandler() async {
    var isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    _form.currentState!.save();

    try {
      String token = Provider.of<RegisterProvider>(context, listen: false).token;
      String doctorName =
          Provider.of<RegisterProvider>(context, listen: false).loggedUserName;
      await Provider.of<PatientProvider>(context, listen: false)
          .createPlace(description, _image!, doctorName, token);

      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Successfully Created'),
          title: Text('Success'),
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Error'),
          title: Text('Error creating place!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter post description";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                      label: Text('post Description'),
                    ),
                    onSaved: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => bottomSheet(),
                            );
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Select Image'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      _image == null
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text('Image Preview'),
                            )
                          : Container(
                              child: Image.file(_image!),
                              height: 160,
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? Container(
                          child: const CircularProgressIndicator(),
                          width: 10,
                          height: 10,
                        )
                      : SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () => createPlaceHandler(),
                            icon: const Icon(Icons.upload),
                            label: const Text('Create post'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
