import 'package:flutter/material.dart';
import 'package:online_attendence_app/screens/add_teacher_screen.dart';
import 'package:online_attendence_app/screens/attendance_screen.dart';
import 'package:online_attendence_app/widgets/attendance_card.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class DepartmenstListScreen extends StatelessWidget {
  const DepartmenstListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = 'Computer Science';
    var members = 22;
    var institution = 'Bahria University Karachi Campus';
    var deleteAction = () {
      var alert = ExitAlertDialogue(
        message: 'Delete this class?',
        action: () {
          Navigator.pop(context);
        },
      );
      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    };
    var addAction = () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddTeacherScreen()));
    };
    var attendanceAction = () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AttendanceScreen(
                    person: 'Teachers',
                  )));
    };
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        title: Text(
          'Departments',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              for (int i = 0; i < 3; i++)
                AttendanceCard(
                    isClass: false,
                    title: title,
                    deleteAction: deleteAction,
                    members: members,
                    institution: institution,
                    addAction: addAction,
                    attendanceAction: attendanceAction)
            ],
          ),
        ),
      ),
    );
  }
}
