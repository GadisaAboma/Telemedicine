import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../provider/register.dart';
import 'doctor_detail_info.dart';

class DoctorsRequest extends StatefulWidget {
  const DoctorsRequest({Key? key}) : super(key: key);

  @override
  State<DoctorsRequest> createState() => _DoctorsRequestState();
}

class _DoctorsRequestState extends State<DoctorsRequest> {
  bool isLoading = false;
  var unApprovedDoctorsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchRequests();
    });
  }

  void fetchRequests() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<RegisterProvider>(context, listen: false)
        .unApprovedDoctors();
    unApprovedDoctorsList =
        Provider.of<RegisterProvider>(context, listen: false)
            .unApprovedDoctorsList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : unApprovedDoctorsList[0] == null
            ? const Center(
                child: Text("There is no unapproved doctor"),
              )
            : ListView.builder(
                itemCount: unApprovedDoctorsList.length,
                itemBuilder: ((_, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(unApprovedDoctorsList[index]["name"]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DoctorDetailInfo(
                                    doctorInfo: unApprovedDoctorsList[index]);
                              },
                            ),
                          );
                        },
                      ),
                      const Divider()
                    ],
                  );
                }),
              );
  }
}
