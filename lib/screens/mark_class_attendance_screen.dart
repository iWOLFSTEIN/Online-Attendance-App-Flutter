import 'package:flutter/material.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';
import 'package:online_attendence_app/widgets/custom_list_tile.dart';

class MarkClassAttendance extends StatefulWidget {
  const MarkClassAttendance({Key? key}) : super(key: key);

  @override
  State<MarkClassAttendance> createState() => _MarkClassAttendanceState();
}

class _MarkClassAttendanceState extends State<MarkClassAttendance> {
  var checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
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
                  children: [
                    for (int i = 0; i < 10; i++)
                      CustomListTile(
                          title: 'Ahmad Khan',
                          id: 'Spring/Bcs/0011',
                          trailingWidget: Checkbox(
                              value: checkBoxValue,
                              onChanged: (value) {
                                if (value != null)
                                  setState(() {
                                    checkBoxValue = value;
                                  });
                              }))
                  ],
                ),
              ),
            )),
            Transform.translate(
              offset: Offset(0, 10),
              child: Material(
                // color: Color(0xFFDFF6FF),
                // color: Colors.blue,
                color:
                    //  Color(0xFF47B5FF),
                    Color(0xFF06283D),
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 42.5,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Names',
                          style: TextStyle(
                              color:
                                  // Colors.white,
                                  // Color(0xFF06283D),
                                  Color(0xFFDFF6FF),
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'Present',
                          style: TextStyle(
                              color:
                                  //  Colors.white,
                                  // Color(0xFF06283D),
                                  Color(0xFFDFF6FF),
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
