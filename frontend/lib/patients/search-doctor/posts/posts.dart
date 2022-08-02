import 'package:flutter/material.dart';

import '../../../widget/post.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Post(),
          Post(),
          Post(),
          Post(),
        ],
      ),
    );
  }
}
