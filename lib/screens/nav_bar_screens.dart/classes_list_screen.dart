import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/class.dart';
import 'package:online_attendence_app/screens/add_student_screen.dart';
import 'package:online_attendence_app/screens/attendance_screen.dart';
import 'package:online_attendence_app/services/Firebase/deletion.dart';
import 'package:online_attendence_app/services/Firebase/queries.dart';
import 'package:online_attendence_app/utils/stream_builder_states.dart';
import 'package:online_attendence_app/widgets/attendance_card.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

// ignore: must_be_immutable
class ClassesListScreen extends StatefulWidget {
  ClassesListScreen({Key? key}) : super(key: key);

  @override
  State<ClassesListScreen> createState() => _ClassesListScreenState();
}

class _ClassesListScreenState extends State<ClassesListScreen> {
  Deletion deletion = Deletion();

  @override
  Widget build(BuildContext context) {
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
            if (!snapshot.hasData) return loading();
            if (listEquals(snapshot.data!.docs, []))
              return info(message: 'No Classes Available');

            List<Widget> widgetsList = [];
            for (var document in snapshot.data!.docs) {
              final classModel = Class.fromDocument(document);
              final classId = document.id;

              var widget = AttendanceCard(
                  isClass: true,
                  title: classModel.subject!,
                  deleteAction: () {
                    var alert = ExitAlertDialogue(
                      message: 'Delete this class?',
                      action: () {
                        deletion.deleteClass(classId: classId);
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
                  members: classModel.members!,
                  institution: classModel.schoolCollege!,
                  addAction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddStudentScreen(
                                  members: classModel.members,
                                  classId: classId,
                                )));
                  },
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
