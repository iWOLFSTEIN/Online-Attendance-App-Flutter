import 'package:flutter/material.dart';

showInfoAlert({required context, required title}) {
  var alert = AlertDialog(
    title: Text(title),
    actions: [
      Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xFF06283D),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white),
            )),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alert;
      });
}
