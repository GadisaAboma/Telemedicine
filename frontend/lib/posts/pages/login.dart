// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import '..//pages/register.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var isLoading = false;
  final _form = GlobalKey<FormState>();
  var email, password;

  Future<void> _loginMe() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });

      await Provider.of<Auth>(context, listen: false).login(email, password);

      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/');
    } on HttpException catch (err) {
      setState(() {
        isLoading = false;
      });

      final error = json.decode(err.toString());

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error Occurred"),
          content: Text(
            error['error'],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } catch (err) {
      setState(() {
        isLoading = false;
      });

      final error = json.decode(err.toString());

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error Occurred"),
          content: Text(
            error['error'],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Places'.toUpperCase(),
                      style: const TextStyle(
                          fontFamily: 'QuickSand',
                          letterSpacing: 4,
                          fontSize: 35,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(
                      height: 30,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 60,
                            width: 200,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey[900],
                                textStyle: const TextStyle(fontSize: 22),
                              ),
                              onPressed: _loginMe,
                              icon: const Icon(Icons.login),
                              label: const Text('Login'),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Don\'t you have account?',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.app_registration),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Register.routeName);
                      },
                      label: const Text('Sign up now'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
