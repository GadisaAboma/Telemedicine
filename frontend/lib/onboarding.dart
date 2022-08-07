// import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_screen/OnbordingData.dart';
// import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

// class TestScreen extends StatelessWidget {
//     /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
//       */
//   final List<OnbordingData> list = [
//     OnbordingData(
//       imagePath: "images/pic11.png",
//       title: "Search",
//       desc:"Discover restaurants by type of meal, See menus and photos for nearby restaurants and bookmark your favorite places on the go",
//     ),
//     OnbordingData(
//       imagePath: "images/pic12.png",
//       title: "Order",
//       desc:"Best restaurants delivering to your doorstep, Browse menus and build your order in seconds",
//     ),
//     OnbordingData(
//       imagePath: "images/pic13.png",
//       title: "Eat",
//       desc:"Explore curated lists of top restaurants, cafes, pubs, and bars in Mumbai, based on trends.",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
//   here we need to pass the list and the route for the next page to be opened after this. */
//     return new IntroScreen(list,MaterialPageRoute(builder: (context) => NextScreen()),
//     );
//   }
// }