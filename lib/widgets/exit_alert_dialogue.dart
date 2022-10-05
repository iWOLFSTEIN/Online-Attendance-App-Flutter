import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAlertDialogue extends StatelessWidget {
  const ExitAlertDialogue({Key? key, this.message, this.action})
      : super(key: key);
  final message;
  final action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (message == null)
          ? const Text("Do you want to exit?")
          : Text(message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No")),
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Color(0xFF06283D),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextButton(
              onPressed: (action == null)
                  ? () {
                      SystemNavigator.pop();
                    }
                  : action,
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
