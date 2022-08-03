import 'package:flutter/material.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../providers/auth.dart';

class MyPlaces extends StatefulWidget {
  const MyPlaces({Key? key}) : super(key: key);

  @override
  State<MyPlaces> createState() => _MyPlacesState();
}

class _MyPlacesState extends State<MyPlaces> {
  bool isLoading = false;
  @override
  void initState() {
    String token = Provider.of<Auth>(context, listen: false).token;

    try {
      setState(() {
        isLoading = true;
      });
      Provider.of<Users>(context, listen: false).fetchMyPlaces(token);
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List myPlaces = Provider.of<Users>(context).myPlaces;
    return Container(
      height: 400,
      child: isLoading
          ? const CircularProgressIndicator()
          : myPlaces.isEmpty
              ? const Text('you haven\'t created any place yet')
              : GridView(
                  children: myPlaces
                      .map(
                        (place) => Image.network(
                            "http://192.168.1.239:3000/${place['imageUrl'].toString().replaceAll("\\", "/")}",
                          ),
                        
                      )
                      .toList(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                ),
    );
  }
}
