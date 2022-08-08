import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:full_screen_image/full_screen_image.dart';

class DoctorDetailInfo extends StatefulWidget {
  final doctorInfo;
  DoctorDetailInfo({this.doctorInfo});

  @override
  State<DoctorDetailInfo> createState() => _DoctorDetailInfoState();
}

class _DoctorDetailInfoState extends State<DoctorDetailInfo> {
  bool isLoading = false;
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctors detail")),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: FullScreenWidget(
                child: InteractiveViewer(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        '$serverUrl/${widget.doctorInfo['idUrl'].toString().replaceAll('\\', '/')}'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text("Name of doctor:  "),
                Text(
                  widget.doctorInfo["name"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Specialized in:  "),
                Text(widget.doctorInfo["specializedIn"])
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          AlertDialog(
                            content: isLoading
                                ? CircularProgressIndicator()
                                : Text("Request Approved"),
                            actions: [
                              !isLoading
                                  ? TextButton(
                                      onPressed: (() async {
                                        Navigator.pop(context);
                                      }),
                                      child: Text("success"))
                                  : Text("Loading")
                            ],
                          );
                          setState(() {
                            isLoading = true;
                          });
                          var success = await Provider.of<RegisterProvider>(
                                  context,
                                  listen: false)
                              .approveDoctor(widget.doctorInfo["_id"]);

                          setState(() {
                            isLoading = false;
                          });

                          if (success == 'success') {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Success!"),
                                    content:
                                        const Text("Successfully approved!"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          Navigator.of(context).pop("refresh");
                                        },
                                        child: const Text("OK"),
                                      )
                                    ],
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Error!"),
                                    content: const Text("Error approving"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            // Navigator.of(context).pop();
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("Approve")),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isDelete = true;
                      });
                      var success = await Provider.of<RegisterProvider>(context,
                              listen: false)
                          .rejectDoctor(widget.doctorInfo["_id"]);
                      setState(() {
                        isDelete = false;
                      });
                      if (success == 'success') {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Success"),
                                content: const Text("Successfully rejected!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(context).pop('refresh');
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Failed"),
                                content: const Text("Failed rejecting!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            });
                      }
                    },
                    child: isDelete
                        ? CircularProgressIndicator()
                        : const Text("Reject")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
