import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/create_class_screen.dart';
import 'package:online_attendence_app/screens/create_department_screen.dart';
import 'package:online_attendence_app/screens/generate_report_screen.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/custom_app_bar.dart';
import 'package:online_attendence_app/widgets/custom_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomAppBar(),
              Container(
                height: height(context) * 30 / 100,
                padding:
                    EdgeInsets.only(right: 15, left: 25, top: 20, bottom: 20),
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
                                fontSize: 30),
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
                  categoryContainer(context, 'images/student.png', 'Students',
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
                  categoryContainer(context, 'images/teacher.png', 'Teachers',
                      'Attendant create departments and add their respective employees',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateDepartmentScreen()));
                  }),
                ],
              ),
              CustomTextButton(
                buttonHeight: height(context) * 8 / 100,
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateReportScreen()));
                },
                title: 'Generate Report',
                fontSize: 17,
              )
            ],
          ),
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
