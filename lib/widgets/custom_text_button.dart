import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.buttonHeight,
      required this.action,
      required this.title,
      required this.fontSize})
      : super(key: key);

  final double buttonHeight;
  final Function() action;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
          color: Color(0xFF06283D),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: TextButton(
        onPressed: action,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
