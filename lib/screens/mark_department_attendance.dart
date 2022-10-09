import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/services/Firebase/updation.dart';
import 'package:online_attendence_app/utils/sort_map.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';
import 'package:online_attendence_app/widgets/title_bar.dart';

class MarkDepartmentAttendance extends StatefulWidget {
  MarkDepartmentAttendance(
      {Key? key, this.attendanceModel, this.attentanceId, this.departmentId})
      : super(key: key);
  final departmentId;
  final attentanceId;
  final Attendance? attendanceModel;
  @override
  State<MarkDepartmentAttendance> createState() =>
      _MarkDepartmentAttendanceState();
}

class _MarkDepartmentAttendanceState extends State<MarkDepartmentAttendance> {
  Updation updation = Updation();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.attendanceModel!.attendance =
        sortMap(attendanceModel: widget.attendanceModel!);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsList = [];
    widget.attendanceModel!.attendance!.forEach((key, value) {
      value.forEach((subKey, subValue) {
        var widget = CustomListTile(
            title: subKey,
            id: key,
            trailingWidget: Checkbox(
                value: subValue,
                onChanged: (value) {
                  updateTeacherAttendance(context, key, subKey, value);
                }));
        widgetsList.add(widget);
      });
    });
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Mark Department Attendance',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Stack(
          fit: StackFit.loose,
          children: [
            SingleChildScrollView(
                child: Transform.translate(
              offset: Offset(0, 62.5),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 65),
                child: Column(
                  children: widgetsList,
                ),
              ),
            )),
            TitleBar(),
          ],
        ),
      ),
    );
  }

  updateTeacherAttendance(
      BuildContext context, key, subKey, bool? value) async {
    try {
      setState(() {
        widget.attendanceModel!.attendance![key][subKey] = value;
      });
      await updation.updateTeacherAttendance(
          departmentId: widget.departmentId,
          attendanceId: widget.attentanceId,
          attendance: widget.attendanceModel!.attendance);
    } catch (e) {}
  }
}
