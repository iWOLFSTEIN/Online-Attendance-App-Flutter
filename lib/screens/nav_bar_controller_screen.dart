import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/nav_bar_screens.dart/classes_list_screen.dart';
import 'package:online_attendence_app/screens/nav_bar_screens.dart/departments_list_screen.dart';
import 'package:online_attendence_app/screens/nav_bar_screens.dart/home_screen.dart';

class NavBarControllerScreen extends StatefulWidget {
  NavBarControllerScreen({Key? key, this.initPageIndex = 0}) : super(key: key);

  var initPageIndex;

  @override
  _NavBarControllerScreenState createState() => _NavBarControllerScreenState();
}

class _NavBarControllerScreenState extends State<NavBarControllerScreen> {
  late PageController controller;
  var pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.initPageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = [
      HomeScreen(),
      ClassesListScreen(),
      DepartmenstListScreen()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: tabItems,
      ),
      bottomNavigationBar: CustomNavigationBar(
          // selectedColor: Color(0xFF68B3DF),
          // strokeColor: Color(0xFF68B3DF),
          elevation: 16,
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
              // controller.animateToPage(pageIndex,
              //     duration: const Duration(milliseconds: 800),
              //     curve: Curves.linearToEaseOut);
            });

            controller.jumpToPage(pageIndex);
          },
          iconSize: 29,
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.home),
              // title: Text('Home'),
              // selectedTitle: Text(
              //   'Home',
              //   style: TextStyle(color: Colors.blue),
              // )
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.class_),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.apartment_outlined),
            )
          ]),
    );
  }
}
