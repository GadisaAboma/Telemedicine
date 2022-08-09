import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';

import '../../widget/notefication_widget.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notifications = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchNotifications();
    });
  }

  void fetchNotifications() async {
    setState(() {
      isLoading = true;
    });
    var loggedId =
        Provider.of<RegisterProvider>(context, listen: false).loggedUserId;
    notifications = await Provider.of<RegisterProvider>(context, listen: false)
        .fetchNotifications(loggedId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : notifications.length == 0
            ? const Center(
                child: Text("No notifications!"),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          notifications[index],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Divider(thickness: 2,)
                    ],
                  );
                },
                itemCount: notifications.length,
              );
  }
}
