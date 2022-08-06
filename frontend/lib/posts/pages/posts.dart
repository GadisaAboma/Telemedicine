import 'package:flutter/material.dart';
import '../pages/profile.dart';
import '../providers/users.dart';
import '../widgets/each_place.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  static const routeName = "/all-users";

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  var _index;
  var _isInit = true;
  var isLoading;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });

    Provider.of<Users>(context, listen: false).fetchPlaces();

    setState(() {
      isLoading = false;
    });
  }

  /*  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });

    if (_isInit) {
      Provider.of<Users>(context, listen: false).fetchUsers();
      setState(() {
        isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  } */

  @override
  Widget build(BuildContext context) {
    List places = Provider.of<Users>(context).places;
    var isAuth = Provider.of<Auth>(context).isAuth;
    String loggedUser = Provider.of<Auth>(context).loggedUser;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          actions: [],
          title: const Text(
            'My Places',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 24),
          ),
        ),
      ),
      bottomNavigationBar: isAuth
          ? BottomNavigationBar(
              onTap: (int index) {
                if (index == 2) {
                  Navigator.of(context).pushNamed(Profile.routeName);
                }
              },
              backgroundColor: Colors.grey[100],
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Home"),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.account_box_rounded),
                    label: loggedUser.split(" ")[0].toString())
              ],
            )
          : BottomNavigationBar(
              backgroundColor: Colors.grey[100],
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Search"),
              ],
            ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, i) => EachPlace(
                    places[i]['description'],
                    places[i]['imageUrl'].toString().replaceAll('\\', '/'),
                    places[i]['date'],
                    places[i]['doctorName']),
                itemCount: places.length,
              ),
            ),
    );
  }
}
