import 'package:flutter/material.dart';

class AddPersonButton extends StatelessWidget {
  const AddPersonButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  final Null Function() action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: Color(0xFF06283D),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextButton(
                onPressed: action,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )),
          )
        ],
      ),
    );
  }
}
