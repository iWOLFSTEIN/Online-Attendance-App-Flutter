import 'package:flutter/material.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/services/firebase/updation.dart';
import 'package:online_attendence_app/utils/sort_map.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';
import "dart:collection";

import '../widgets/title_bar.dart';

class MarkClassAttendance extends StatefulWidget {
  const MarkClassAttendance({
    Key? key,
    this.attendanceModel,
    this.classId,
    this.attentanceId,
  }) : super(key: key);
  final classId;
  final attentanceId;
  final Attendance? attendanceModel;

  @override
  State<MarkClassAttendance> createState() => _MarkClassAttendanceState();
}

class _MarkClassAttendanceState extends State<MarkClassAttendance> {
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
                  updateStudentAttendance(context, key, subKey, value);
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
          'Mark Class Attendance',
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

  updateStudentAttendance(context, key, subKey, value) async {
    try {
      setState(() {
        widget.attendanceModel!.attendance![key][subKey] = value;
      });
      await updation.updateStudentAttendance(
          classId: widget.classId,
          attendanceId: widget.attentanceId,
          attendance: widget.attendanceModel!.attendance);
    } catch (e) {}
  }
}
