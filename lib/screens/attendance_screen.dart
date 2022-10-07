import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/mark_class_attendance_screen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key, required this.person}) : super(key: key);
  final person;
  @override
  Widget build(BuildContext context) {
    var title = '12/12/2022';
    var subtitle = person + ' Present: 20';
    var action = () {
      // if (person == 'Students')
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MarkClassAttendance()));
    };
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Attendances',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.info_outline,
              color: Colors.black.withOpacity(0.6),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              for (int i = 0; i < 10; i++)
                attendanceTile(i, action, title, subtitle)
            ],
          ),
        ),
      ),
      floatingActionButton: Material(
        elevation: 8,
        color: Color(0xFF06283D),
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: Container(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Create',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  Padding attendanceTile(int i, Null action(), String title, subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: (i == 0) ? 4 : 0,
        color: (i == 0)
            ? Color(0xFF06283D)
            :
            //  Color(0xFFDFF6FF),
            Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: double.infinity,
          child: ListTile(
            onTap: action,
            title: Text(
              title,
              style:
                  TextStyle(color: (i == 0) ? Colors.white : Color(0xFF06283D)),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                  color: (i == 0)
                      ? Colors.white.withOpacity(1.0)
                      : Color(0xFF06283D).withOpacity(1.0)),
            ),
            trailing: Icon(Icons.arrow_forward,
                color: (i == 0) ? Colors.white : Color(0xFF06283D)),
          ),
        ),
      ),
    );
  }
}
