import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/provider/doctor.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';
import '../appointment/styles/colors.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var name, username, password, type, id;
  bool isLoading = false;

  void updateInfo() async {
    setState(() {
      isLoading = true;
    });
    var updatedInfo = await Provider.of<DoctorProvider>(context, listen: false)
        .updateUserInfo(name, password, type, username, id);
    setState(() {
      isLoading = false;
    });

    if (updatedInfo == 'success') {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Successfully Updated!"),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Failed"),
              content: const Text("Failed to update!"),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    setState(() {
      name =
          Provider.of<RegisterProvider>(context, listen: false).loggedUserName;
      username = Provider.of<RegisterProvider>(context, listen: false).username;
      password = Provider.of<RegisterProvider>(context, listen: false).passWord;
      id = Provider.of<RegisterProvider>(context, listen: false).loggedId;
      type =
          Provider.of<RegisterProvider>(context, listen: false).loggedUserType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill all information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Column(children: [
            TextFormField(
              onChanged: ((value) => name = value),
              initialValue: name,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter new name',
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: username,
              onChanged: ((value) => username = value),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter new username',
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: password,
              onChanged: ((value) => password = value),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter new password',
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.update),
                      onPressed: () {
                        updateInfo();
                      },
                      label: const Text("Update"),
                    ),
                  )
          ]),
        ),
      ),
    );
  }
}
