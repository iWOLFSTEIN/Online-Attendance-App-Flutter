import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

loading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

info({required message}) {
  return Container(
    child: Center(
        child: Text(
      message,
      style: TextStyle(color: Color(0xFF06283D).withOpacity(0.4)),
    )),
  );
}
