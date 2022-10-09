import 'package:flutter/material.dart';

class AttendanceListTile extends StatelessWidget {
  const AttendanceListTile({
    Key? key,
    required this.i,
    required this.action,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final int i;
  final Null Function() action;
  final String title;
  final subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: (i == 0) ? 4 : 0,
        color: (i == 0) ? Color(0xFF06283D) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: double.infinity,
          child: ListTile(
            onTap: action,
            title: Text(
              title,
              style:
                  TextStyle(color: (i == 0) ? Colors.white : Color(0xFF06283D)),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                  color: (i == 0)
                      ? Colors.white.withOpacity(1.0)
                      : Color(0xFF06283D).withOpacity(1.0)),
            ),
            trailing: Icon(Icons.arrow_forward,
                color: (i == 0) ? Colors.white : Color(0xFF06283D)),
          ),
        ),
      ),
    );
  }
}
