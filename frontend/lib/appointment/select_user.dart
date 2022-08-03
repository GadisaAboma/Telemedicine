import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../provider/patient.dart';
import './styles/colors.dart';
import './styles/styles.dart';
import '../utils/helpers.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  bool isLoading = false;
  List<dynamic> patient = [];
  var username;
  TextEditingController _controller = new TextEditingController();

  void _searchDoctor(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    dynamic returnedPatient =
        await Provider.of<PatientProvider>(listen: false, context)
            .searchPatient(username);
    if (returnedPatient != null) {
      setState(() {
        print(returnedPatient);
        patient = returnedPatient;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select user"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.search,
                      color: Color(MyColors.purple02),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: ((value) => username = value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a patient',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color(MyColors.purple01),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                    });
                    _searchDoctor(context);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
              ),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : patient.isEmpty
                    ? const Center(
                        child: Text("No patient found with this username"),
                      )
                    : Container(
                      height: 400,
                      child: ListView.builder(
                          itemCount: patient.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(setAppointment, arguments: {
                                'id': patient[index]._id,
                                'name': patient[index].name
                              }),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/image/doctor.jpg"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                patient[index].name,
                                                style: TextStyle(
                                                  color: Color(MyColors.header01),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "patient",
                                                style: TextStyle(
                                                  color: Color(MyColors.grey02),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
          ],
        ),
      ),
    );
  }
}
