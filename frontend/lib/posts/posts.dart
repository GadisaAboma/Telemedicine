import 'package:flutter/material.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';
import './widgets/each_place.dart';

import '../widget/post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool isLoading = true;
  List places = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        fetchPosts();
      },
    );
  }

  void fetchPosts() async {
    await Provider.of<PatientProvider>(context, listen: false).fetchPosts();
    places = Provider.of<PatientProvider>(context, listen: false).places;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
            height: 700,
            child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return EachPlace(
                      places[index]['description'],
                      places[index]['imageUrl'].toString().replaceAll('\\', '/'),
                      places[index]['date']);
                },
              ),
          ),
    );
  }
}
