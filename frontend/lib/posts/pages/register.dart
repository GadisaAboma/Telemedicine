// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import '../pages/login.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'dart:convert';

class Register extends StatefulWidget {
  static const routeName = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var isLoading = false;
  var name, email, password;
  final _form = GlobalKey<FormState>();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occured!'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }

  Future<void> _registerMe() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    _form.currentState!.save();

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(name, email, password);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Success'),
          content: const Text("Successfully Created!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),),
          ],
        ),
      );
    } on HttpException catch (err) {
      final error = json.decode(err.toString());
      _showDialog(error['error']);
    } catch (err) {
      final error = json.decode(err.toString());
      _showDialog(error['error']);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'My Places',
                    style: TextStyle(
                        fontFamily: 'QuickSand',
                        fontSize: 35,
                        color: Colors.blueGrey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.account_box),
                      border: OutlineInputBorder(),
                      label: Text('Full Name'),
                    ),
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const SizedBox(
                      height: 30,
                    ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          margin: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 60,
                            width: 200,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey[900],
                                textStyle: const TextStyle(fontSize: 22),
                              ),
                              onPressed: _registerMe,
                              icon: const Icon(Icons.app_registration),
                              label: const Text('Register'),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.login),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Login.routeName);
                    },
                    label: const Text('Login instead'),
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
