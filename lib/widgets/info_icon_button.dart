import 'package:flutter/material.dart';

class InfoIconButton extends StatelessWidget {
  const InfoIconButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  final Null Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Icon(
          Icons.info_outline,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
