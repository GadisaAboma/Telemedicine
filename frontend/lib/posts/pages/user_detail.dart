import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key}) : super(key: key);

  static const routeName = '/user-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
           iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('User Places'),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    Image.asset('assets/place.jpg'),
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(3),
             
              child: Column(
                children: [
                  Image.asset('assets/place2.jpg'),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
