import 'package:flutter/material.dart';

class LabeledFormField extends StatelessWidget {
  const LabeledFormField({
    Key? key,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF06283D),
                fontSize: 18.5,
                // fontWeight: FontWeight.w600
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.5,
                // fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        SizedBox(
          height: 11,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF256D85).withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              // border: Border.all(color: Color(0xFF256D85))
            ),
            child: Center(
              child: TextFormField(
                style: TextStyle(color: Color(0xFF06283D), fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isCollapsed: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: Color(0xFF06283D).withOpacity(0.4),
                        fontSize: 18)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
