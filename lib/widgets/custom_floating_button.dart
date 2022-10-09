import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
    required this.action,
    required this.title,
  }) : super(key: key);

  final Null Function() action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: Color(0xFF06283D),
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: Container(
        height: 50,
        width: 130,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
        child: TextButton(
          onPressed: action,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
