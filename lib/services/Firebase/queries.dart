import 'dart:async';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

Stream getClasses = firebaseFirestore
    .collection('users')
    .doc(uid)
    .collection('classes')
    .snapshots();

Stream getDepartments = firebaseFirestore
    .collection('users')
    .doc(uid)
    .collection('departments')
    .snapshots();

Stream getStudents({required classId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('classes')
      .doc(classId)
      .collection('students')
      .snapshots();
}

Stream getTeachers({required departmentId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('departments')
      .doc(departmentId)
      .collection('teachers')
      .snapshots();
}
