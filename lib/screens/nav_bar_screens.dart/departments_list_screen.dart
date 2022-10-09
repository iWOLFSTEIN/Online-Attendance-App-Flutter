import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/department.dart';
import 'package:online_attendence_app/screens/add_teacher_screen.dart';
import 'package:online_attendence_app/screens/class_attendances_screen.dart';
import 'package:online_attendence_app/services/firebase/deletion.dart';
import 'package:online_attendence_app/services/firebase/queries.dart';
import 'package:online_attendence_app/utils/stream_builder_states.dart';
import 'package:online_attendence_app/widgets/attendance_card.dart';
import 'package:online_attendence_app/widgets/exit_alert_dialogue.dart';

class DepartmenstListScreen extends StatefulWidget {
  DepartmenstListScreen({Key? key}) : super(key: key);

  @override
  State<DepartmenstListScreen> createState() => _DepartmenstListScreenState();
}

class _DepartmenstListScreenState extends State<DepartmenstListScreen> {
  Deletion deletion = Deletion();

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
          stream: getDepartments,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loading();
            if (listEquals(snapshot.data!.docs, []))
              return info(message: 'No Departments Available');

            List<Widget> widgetsList = [];
            for (var document in snapshot.data!.docs) {
              final departmentModel = Department.fromDocument(document);
              final departmentId = document.id;

              var widget = AttendanceCard(
                  isClass: false,
                  title: departmentModel.department!,
                  deleteAction: () {
                    var alert = ExitAlertDialogue(
                      message: 'Delete this department?',
                      action: () {
                        deletion.deleteDepartment(departmentId: departmentId);
                        Navigator.pop(context);
                      },
                    );
                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });
                  },
                  program: departmentModel.field,
                  semester: departmentModel.location,
                  members: departmentModel.members!,
                  institution: departmentModel.organization!,
                  addAction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTeacherScreen(
                                  departmentId: departmentId,
                                  members: departmentModel.members,
                                )));
                  },
                  attendanceAction: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AttendanceScreen(
                    //               persons: 'teachers',
                    //               classOrDepartmentId: departmentId,
                    //             )));
                  });

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
