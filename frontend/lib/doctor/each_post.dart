import 'package:flutter/material.dart';
import 'package:frontend/utils/helpers.dart';
import 'package:intl/intl.dart';

class EachPost extends StatefulWidget {
  var description;
  Function deletePost;
  var imageUrl;
  var date;
  var doctorName;
  var postId;
  EachPost(this.description, this.imageUrl, this.date, this.doctorName,
      this.postId, this.deletePost);

  @override
  State<EachPost> createState() => _EachPostState();
}

class _EachPostState extends State<EachPost> {
  bool isDelete = false;
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  void confirmDelete() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Are you sure?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  widget.deletePost(widget.postId);
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("No"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //widget.date = DateTime.parse(widget.date);
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/image/doctor.jpg',
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          "${widget.doctorName} posted a post",
                          style: const TextStyle(
                              fontSize: 19,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isDelete = !isDelete;
                                  });
                                },
                                icon: Icon(Icons.more_vert)),
                            isDelete
                                ? Positioned(
                                    bottom: 0,
                                    child: TextButton(
                                        child: Text("delete"),
                                        onPressed: () {
                                          // widget.deletePost(widget.postId);
                                          confirmDelete();
                                        }))
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Text(timeAgo(widget.date)),
                  Text(widget.date)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Image.network('$serverUrl/${widget.imageUrl}'),

          const SizedBox(
            width: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     TextButton.icon(
          //       label: const Text('Like'),
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.thumb_up_alt_outlined,
          //         color: Colors.black,
          //       ),
          //     ),
          //     TextButton.icon(
          //       onPressed: () {},
          //       icon: const Icon(Icons.favorite_border),
          //       label: const Text('Favorite'),
          //     ),
          //     TextButton.icon(
          //       onPressed: () {},
          //       label: const Text('View'),
          //       icon: const Icon(
          //         Icons.place,
          //         color: Colors.orange,
          //       ),
          //     ),
          //   ],
          // ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
