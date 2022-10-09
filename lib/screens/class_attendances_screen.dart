import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/screens/mark_class_attendance_screen.dart';
import 'package:online_attendence_app/services/firebase/creation.dart';
import 'package:online_attendence_app/utils/stream_builder_states.dart';
import '../services/Firebase/queries.dart';
import '../utils/error_alert.dart';
import '../widgets/attendance_list_tile.dart';
import '../widgets/custom_floating_button.dart';
import '../widgets/info_icon_button.dart';

class ClassAttendancesScreen extends StatefulWidget {
  const ClassAttendancesScreen({Key? key, required this.classId})
      : super(key: key);
  final classId;

  @override
  State<ClassAttendancesScreen> createState() => _ClassAttendancesScreenState();
}

class _ClassAttendancesScreenState extends State<ClassAttendancesScreen> {
  Future? studentsFutureData;
  Creation creation = Creation();
  var classId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentsFutureData = getStudentsFutureData(classId: widget.classId);
    classId = widget.classId;
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [InfoIconButton(action: () {})],
      ),
      body: StreamBuilder(
          stream: getStudentsAttendances(classId: classId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loading();
            if (listEquals(snapshot.data!.docs, []))
              return info(message: 'No Attendances Available');

            List<Widget> widgetsList = [];
            for (var document in snapshot.data!.docs) {
              Attendance attendanceModel = Attendance.fromDocument(document);
              var attendanceId = document.id;
              int studentsPresent = 0;
              for (var miniMap in attendanceModel.attendance!.values) {
                if (miniMap.values.first) studentsPresent += 1;
              }
              var dateTime = DateTime.now();
              var creationTime = attendanceModel.creationTime;

              var timeDifference = dateTime.difference(creationTime!).inHours;

              var widget = AttendanceListTile(
                  i: (timeDifference <= 24) ? 0 : 1,
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MarkClassAttendance(
                                  classId: classId,
                                  attentanceId: attendanceId,
                                  attendanceModel: attendanceModel,
                                )));
                  },
                  title: attendanceModel.creationTime!.toString(),
                  subtitle: 'Students Present: $studentsPresent');

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
      floatingActionButton: CustomFloatingButton(
          action: () {
            createClassAttendance(context);
          },
          title: 'Create'),
    );
  }

  createClassAttendance(context) {
    studentsFutureData!.then((future) async {
      if (!listEquals(future.docs, [])) {
        Map attendance = {};
        for (var entity in future.docs) {
          var document = entity.data() as Map;
          attendance[document['registrationNo']] = {document['name']: false};
        }
        try {
          final dateTime = DateTime.now();
          await creation.createClassAttendance(
              attendanceModel:
                  Attendance(attendance: attendance, creationTime: dateTime),
              classId: classId);
        } catch (e) {
          print(e.toString());
          showInfoAlert(context: context, title: 'An error occurred.');
        }
      } else {
        showInfoAlert(context: context, title: 'No student added');
      }
    });
  }
}
