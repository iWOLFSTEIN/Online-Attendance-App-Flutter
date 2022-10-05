import 'package:flutter/material.dart';
import 'package:online_attendence_app/widgets/attendance_card.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class ClassesListScreen extends StatelessWidget {
  const ClassesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = 'Data Science Class';
    var members = 52;
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
    var addAction = () {};
    var attendanceAction = () {};
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        title: Text(
          'Classes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              for (int i = 0; i < 2; i++)
                AttendanceCard(
                    isClass: true,
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
