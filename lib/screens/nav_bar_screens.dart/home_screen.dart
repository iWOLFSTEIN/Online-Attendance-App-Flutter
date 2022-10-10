import 'package:flutter/material.dart';
import 'package:online_attendence_app/provider/data_provider.dart';
import 'package:online_attendence_app/screens/create_class_screen.dart';
import 'package:online_attendence_app/screens/create_department_screen.dart';
import 'package:online_attendence_app/screens/generate_report_screen.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/custom_app_bar.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBottomContainerVisible = false;
  bool isBottomContainerContentVisible = false;
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomAppBar(),
                  Container(
                    height: height(context) * 30 / 100,
                    padding: EdgeInsets.only(
                        right: 15, left: 25, top: 20, bottom: 20),
                    width: width(context),
                    decoration: BoxDecoration(
                        color: Color(0xFF06283D),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attendance Online',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28),
                              ),
                              textItem('Keep Records'),
                              textItem('Generate Reports'),
                              textItem('Realtime Attendance'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            'images/attendance_list.png',
                            height: 130,
                            width: 130,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      categoryContainer(
                          context,
                          'images/student.png',
                          'Students',
                          'Teachers create classes and add students in each class',
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateClassScreen()));
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      categoryContainer(
                          context,
                          'images/teacher.png',
                          'Teachers',
                          'Attendant create departments and add their respective employees',
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateDepartmentScreen()));
                      }),
                    ],
                  ),
                  CustomTextButton(
                    buttonHeight: height(context) * 8 / 100,
                    action: () {
                      setState(() {
                        isBottomContainerVisible = true;
                      });
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          isBottomContainerContentVisible = true;
                        });
                      });
                    },
                    title: 'Generate Report',
                    fontSize: 17,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (isBottomContainerVisible)
                      ? Expanded(
                          child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isBottomContainerContentVisible = false;
                              isBottomContainerVisible = false;
                            });
                          },
                          child: Container(
                            color: Colors.green.withOpacity(0.0),
                          ),
                        ))
                      : Container(),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: double.infinity,
                    height: (isBottomContainerVisible) ? 150 : 0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: (isBottomContainerContentVisible)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bottomContainerButton(
                                    title: 'Class',
                                    action: () {
                                      dataProvider.isClass = true;
                                      gotoGenerateReportScreen();
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                bottomContainerButton(
                                    title: 'Department',
                                    action: () {
                                      dataProvider.isClass = false;
                                      gotoGenerateReportScreen();
                                    }),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  gotoGenerateReportScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GenerateReportScreen()));
    setState(() {
      isBottomContainerContentVisible = false;
      isBottomContainerVisible = false;
    });
  }

  Container bottomContainerButton({required title, required action}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFDFF6FF),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: TextButton(
        onPressed: action,
        child: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Expanded categoryContainer(BuildContext context, String imageAddress,
      String title, String description, Null action()) {
    return Expanded(
      child: Container(
        height: height(context) * 37.5 / 100,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: Color(0xFF47B5FF),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                imageAddress,
                height: 90,
                width: 90,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Color(0xFF06283D),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF06283D).withOpacity(0.4),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF06283D),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: TextButton(
                onPressed: action,
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text textItem(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14.5),
    );
  }
}
