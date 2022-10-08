import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/class.dart';
import 'package:online_attendence_app/screens/add_student_screen.dart';
import 'package:online_attendence_app/screens/attendance_screen.dart';
import 'package:online_attendence_app/services/Firebase/deletion.dart';
import 'package:online_attendence_app/services/Firebase/queries.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/attendance_card.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class ClassesListScreen extends StatelessWidget {
  ClassesListScreen({Key? key}) : super(key: key);
  Deletion deletion = Deletion();
  @override
  Widget build(BuildContext context) {
    var deleteAction = () {
      var alert = ExitAlertDialogue(
        message: 'Delete this class?',
        action: () {
          deletion.deleteClass(classId: '');
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
          context, MaterialPageRoute(builder: (context) => AddStudentScreen()));
    };
    var attendanceAction = () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AttendanceScreen(
                    person: 'Students',
                  )));
    };
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
      body: StreamBuilder(
          stream: getClasses,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            if (listEquals(snapshot.data!.docs, []))
              return Container(
                child: Center(
                    child: Text(
                  'No Classes Available',
                  style: TextStyle(color: Color(0xFF06283D).withOpacity(0.4)),
                )),
              );

            List<Widget> widgetsList = [];
            for (var document in snapshot.data!.docs) {
              final classModel = Class.fromDocument(document);
              final classModelId = document.id;

              var widget = AttendanceCard(
                  isClass: true,
                  title: classModel.subject!,
                  deleteAction: () {
                    var alert = ExitAlertDialogue(
                      message: 'Delete this class?',
                      action: () {
                        deletion.deleteClass(classId: classModelId);
                        Navigator.pop(context);
                      },
                    );
                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });
                  },
                  program: classModel.program,
                  semester: classModel.semesterSection,
                  members: 0,
                  institution: classModel.schoolCollege!,
                  addAction: addAction,
                  attendanceAction: attendanceAction);

              widgetsList.add(widget);
            }
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: widgetsList,
                ),
              ),
            );
          }),
    );
  }
}
