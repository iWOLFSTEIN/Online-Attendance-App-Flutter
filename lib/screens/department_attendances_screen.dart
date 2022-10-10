import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/screens/mark_department_attendance.dart';
import 'package:online_attendence_app/services/Firebase/creation.dart';
import 'package:online_attendence_app/services/Firebase/queries.dart';
import 'package:online_attendence_app/utils/error_alert.dart';
import 'package:online_attendence_app/utils/stream_builder_states.dart';
import 'package:online_attendence_app/widgets/attendance_list_tile.dart';
import 'package:online_attendence_app/widgets/custom_floating_button.dart';
import 'package:online_attendence_app/widgets/info_icon_button.dart';

class DepartmentAttendanceScreen extends StatefulWidget {
  DepartmentAttendanceScreen({Key? key, this.departmentId}) : super(key: key);
  final departmentId;
  @override
  State<DepartmentAttendanceScreen> createState() =>
      _DepartmentAttendanceScreenState();
}

class _DepartmentAttendanceScreenState
    extends State<DepartmentAttendanceScreen> {
  Future? teachersFutureData;
  Creation creation = Creation();
  var departmentId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teachersFutureData =
        getTeachersFutureData(departmentId: widget.departmentId);
    departmentId = widget.departmentId;
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
          stream: getTeachersAttendances(departmentId: departmentId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return loading();
            if (listEquals(snapshot.data!.docs, []))
              return info(message: 'No Attendances Available');

            List<Widget> widgetsList = [];
            for (var document in snapshot.data!.docs) {
              Attendance attendanceModel = Attendance.fromDocument(document);
              var attendanceId = document.id;
              int teachersPresent = 0;
              for (var miniMap in attendanceModel.attendance!.values) {
                if (miniMap.values.first) teachersPresent += 1;
              }
              var dateTime = DateTime.now();
              var creationTime = attendanceModel.creationTime;

              bool sameDay = dateTime.day == creationTime!.day;
              bool sameMonth = dateTime.month == creationTime.month;
              bool sameYear = dateTime.year == creationTime.year;

              var widget = AttendanceListTile(
                  i: (sameYear && sameMonth && sameDay) ? 0 : 1,
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MarkDepartmentAttendance(
                                  departmentId: departmentId,
                                  attentanceId: attendanceId,
                                  attendanceModel: attendanceModel,
                                )));
                  },
                  title: attendanceModel.creationTime!.toString(),
                  subtitle: 'Teachers Present: $teachersPresent');

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
            createDepartmentAttendance(context);
          },
          title: 'Create'),
    );
  }

  createDepartmentAttendance(context) {
    teachersFutureData!.then((future) async {
      if (!listEquals(future.docs, [])) {
        Map attendance = {};
        for (var entity in future.docs) {
          var document = entity.data() as Map;
          attendance[document['id']] = {document['name']: false};
        }
        try {
          final dateTime = DateTime.now();
          await creation.createDepartmentAttendance(
              attendanceModel:
                  Attendance(attendance: attendance, creationTime: dateTime),
              departmentId: departmentId);
        } catch (e) {
          print(e.toString());
          showInfoAlert(context: context, title: 'An error occurred.');
        }
      } else {
        showInfoAlert(context: context, title: 'No Teacher added');
      }
    });
  }
}
