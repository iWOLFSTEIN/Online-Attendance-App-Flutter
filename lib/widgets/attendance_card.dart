import 'package:flutter/material.dart';
import 'package:online_attendence_app/utils/screen_dimensions.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard(
      {Key? key,
      required this.title,
      required this.deleteAction,
      required this.members,
      required this.institution,
      required this.addAction,
      required this.attendanceAction,
      required this.program,
      required this.semester,
      required this.isClass})
      : super(key: key);

  final String title;
  final Null Function() deleteAction;
  final int members;
  final String institution;
  final Null Function() addAction;
  final Null Function() attendanceAction;
  final bool isClass;
  final semester;
  final program;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 8,
        shadowColor: Colors.white,
        color: Color(0xFF47B5FF),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: height(context) * 30 / 100,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          width: width(context),
          decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Color(0xFF06283D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(top: 5, right: 5),
                            child: GestureDetector(
                              onTap: deleteAction,
                              child: Icon(
                                Icons.delete,
                                color: Color(0xFFDFF6FF),
                              ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '$program',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF06283D).withOpacity(0.4),
                          ),
                        ),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          '$semester',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF06283D).withOpacity(0.4),
                          ),
                        ),
                        SizedBox(
                          width: 12.5,
                        ),
                        Icon(
                          Icons.person,
                          color: Color(0xFF06283D).withOpacity(0.4),
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$members',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF06283D).withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      institution,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFDFF6FF).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    width: 135,
                    decoration: BoxDecoration(
                        color: Color(0xFFDFF6FF),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                      onPressed: addAction,
                      child: Text(
                        (isClass) ? 'Add Student' : 'Add Teacher',
                        style: TextStyle(
                          color: Color(0xFF06283D),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 60,
                    width: 135,
                    decoration: BoxDecoration(
                        color: Color(0xFF06283D),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                      onPressed: attendanceAction,
                      child: Text(
                        'Attendance',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
