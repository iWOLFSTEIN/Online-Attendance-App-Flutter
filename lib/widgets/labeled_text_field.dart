import 'package:flutter/material.dart';

class LabeledFormField extends StatelessWidget {
  const LabeledFormField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onValidate,
  }) : super(key: key);

  final String label;
  final String hintText;
  final controller;
  final onValidate;

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
          child: TextFormField(
            controller: controller,
            validator: onValidate,
            style: TextStyle(color: Color(0xFF06283D), fontSize: 18),
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF256D85).withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Color(0xFF06283D).withOpacity(0.4), fontSize: 18)),
          ),
        )
      ],
    );
  }
}
