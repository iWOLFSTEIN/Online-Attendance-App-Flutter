import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 10),
      child: Material(
        color: Color(0xFF06283D),
        elevation: 4,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: Container(
          height: 42.5,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Names',
              style: TextStyle(
                  color: Color(0xFFDFF6FF),
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(child: Container()),
            Text(
              'Present',
              style: TextStyle(
                  color: Color(0xFFDFF6FF),
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ]),
        ),
      ),
    );
  }
}
