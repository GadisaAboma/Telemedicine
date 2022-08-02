import 'package:flutter/material.dart';
import 'package:frontend/utils/helpers.dart';
import '../helpers/date_calculator.dart';
import '../pages/user_detail.dart';
import 'package:intl/intl.dart';

class EachPlace extends StatelessWidget {
  var description;
  var imageUrl;
  var date;

  EachPlace(this.description, this.imageUrl, this.date);

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

  @override
  Widget build(BuildContext context) {
    date = DateTime.parse(date);
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
                children: [
                  const Text(
                    "Gadisa Aboma posted a post",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(timeAgo(date)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(UserDetail.routeName),
            child: Image.network('$serverUrl/$imageUrl'),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                label: const Text('Like'),
                onPressed: () {},
                icon: const Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.black,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                label: const Text('Favorite'),
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('View'),
                icon: const Icon(
                  Icons.place,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
