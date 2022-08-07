import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../provider/register.dart';
import '../provider/patient.dart';
import '../posts/widgets/each_place.dart';

class AdminPost extends StatefulWidget {
  const AdminPost({Key? key}) : super(key: key);

  @override
  State<AdminPost> createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  bool isLoading = false;
  List posts = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        fetchPosts();
      },
    );
  }

  void fetchPosts() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<PatientProvider>(context, listen: false).fetchPosts();
    posts = Provider.of<PatientProvider>(context, listen: false).posts;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: 700,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return EachPlace(
                      posts[index]['description'],
                      posts[index]['imageUrl'].toString().replaceAll('\\', '/'),
                      posts[index]['date'],
                      posts[index]['doctorName']);
                },
              ),
            ),
    );
  }
}
