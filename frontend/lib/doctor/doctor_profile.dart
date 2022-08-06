import 'package:flutter/material.dart';
import 'package:frontend/provider/patient.dart';
import 'package:frontend/provider/register.dart';
import 'package:provider/provider.dart';
import 'each_post.dart';
import '../provider/doctor.dart';

class DoctorProfile extends StatefulWidget {
  final doctorinfo;
  DoctorProfile({this.doctorinfo});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isLoading = false;
  List doctorPosts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchDoctorPosts();
    });
  }

  void deletePost(String id) async {
    await Provider.of<DoctorProvider>(context, listen: false).deletePost(id);
    fetchDoctorPosts();
  }

  void fetchDoctorPosts() async {
    setState(() {
      isLoading = true;
    });
    var token = Provider.of<RegisterProvider>(context, listen: false).token;
    await Provider.of<DoctorProvider>(context, listen: false)
        .fetchDoctorPosts(token);

    doctorPosts =
        Provider.of<DoctorProvider>(context, listen: false).doctorPosts;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.doctorinfo["name"])),
        body: ListView(children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("assets/image/doctor.jpg"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.perm_identity,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Full name: "),
              const SizedBox(
                width: 10,
              ),
              Text(widget.doctorinfo["name"])
            ],
          ),
          const Divider(
            thickness: 3,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              :
              // : SizedBox(
              //     height: 700,
              //     child: ListView.builder(
              //       itemCount: doctorPosts.length,
              //       itemBuilder: (context, index) {
              //         return EachPlace(
              //             doctorPosts[index]['description'],
              //             doctorPosts[index]['imageUrl']
              //                 .toString()
              //                 .replaceAll('\\', '/'),
              //             doctorPosts[index]['date'],
              //             doctorPosts[index]['doctorName']);
              //       },
              //     ),
              //   ),
              Column(
                  children: doctorPosts.reversed
                      .toList()
                      .map((posts) => EachPost(
                            posts['description'],
                            posts['imageUrl'].toString().replaceAll('\\', '/'),
                            posts['date'],
                            posts['doctorName'],
                            posts['_id'],
                            deletePost,
                          ))
                      .toList()),
        ])

        // SingleChildScrollView(
        //   child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //     Container(
        //       margin: const EdgeInsets.only(top: 10),
        //       alignment: Alignment.center,
        //       child: const CircleAvatar(
        //         radius: 100,
        //         backgroundImage: AssetImage("assets/image/doctor.jpg"),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     Row(
        //       children: [
        //         const Icon(
        //           Icons.perm_identity,
        //         ),
        //         const SizedBox(
        //           width: 10,
        //         ),
        //         const Text("Full name: "),
        //         const SizedBox(
        //           width: 10,
        //         ),
        //         Text(widget.doctorinfo["name"])
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),

        //     SizedBox(
        //       height: 20,
        //     ),
        //     Row(
        //       children: [
        //         Icon(
        //           Icons.g_mobiledata,
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text("Gender: "),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text(widget.doctorinfo["gender"])
        //       ],
        //     ),

        //   ]),
        );
  }
}
