
import 'package:flutter/material.dart';

import '../widget/notefication_widget.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
          NotificationWidget(),
        ],
      ),
    );
  }
}
