import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:staff_face/presentation/home/views/dashboard/dashboard.dart';
import 'package:staff_face/theme/Colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> views = const [
    Dashboard(),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      /// You can use an AppBar if you want to
      //appBar: AppBar(
      //  title: const Text('App'),
      //),

      // The row is needed to display the current view
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
                        icon: Icons.dashboard,
                        label: 'Dashboard',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.person,
                        label: 'Account',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.settings,
                        label: 'Settings',
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),

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
                height: size.height * 0.15,
                width: size.width,
                child: Container(
                  color: color7,
                )),
            Positioned(
                left: size.width * 0.05,
                child: Container(
                  color: Colors.black,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 100,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
