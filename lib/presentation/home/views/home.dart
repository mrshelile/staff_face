import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:staff_face/presentation/crudeOperations/addemployee.dart';
import 'package:staff_face/presentation/home/views/dashboard/dashboard.dart';
import 'package:staff_face/theme/Colors.dart';

import 'attendancescreen.dart';
import 'employeesscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> views = [
    const Dashboard(),
    const Attendance(),
    Employees(),
  ];
  final _formKey = GlobalKey<FormState>();
  String _inputValue = '';

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      body: Container(
        color: color7,
        child: Stack(
          children: [
            Row(
              children: [
                /// Pretty similar to the BottomNavigationBar!
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.15),
                  child: SideNavigationBar(
                    selectedIndex: selectedIndex,
                    items: const [
                      SideNavigationBarItem(
                        icon: Icons.dashboard_outlined,
                        label: 'Dashboard',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.person_add_alt,
                        label: 'Attendance',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.people_alt,
                        label: 'Employees',
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
                // SizedBox(height: 150,),
                /// Make it take the rest of the available width
                Expanded(
                  child: Container(
                      color: colorPallate[5],
                      child: views.elementAt(selectedIndex)),
                )
              ],
            ),
            Positioned(
                left: size.width * 0,
                height: size.height * 0.10,
                width: size.width,
                child: Container(
                  color: color7,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Positioned(
                left: size.width * 0.015,
                child: Container(
                  color: Colors.black,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color7,
        onPressed: () {
          
          setState(() {
            _showAddEmployeeDialog(context);
          });
        },
        child: Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddEmployeeDialog(BuildContext context) {
    print("Show Dialog");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddEmployee();
      },
    );
  }
}
