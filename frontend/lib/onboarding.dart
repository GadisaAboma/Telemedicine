import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

import 'login/login.dart';

class TestScreen extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "assets/image/back.jpg",
      title: "Search",
      desc:
          "Discover restaurants by type of meal, See menus and photos for nearby restaurants and bookmark your favorite places on the go",
    ),
    OnbordingData(
      imagePath: "assets/image/background.jpg",
      title: "Order",
      desc:
          "Best restaurants delivering to your doorstep, Browse menus and build your order in seconds",
    ),
    OnbordingData(
      imagePath: "assets/image/doctor.jpg",
      title: "Eat",
      desc:
          "Explore curated lists of top restaurants, cafes, pubs, and bars in Mumbai, based on trends.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final length = list.length;
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      list,
      MaterialPageRoute(
        builder: (context) => length == 2? TestScreen() :Login(),
        fullscreenDialog: true,
      ),
    );
  }
}
