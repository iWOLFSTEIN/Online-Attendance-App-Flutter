import 'dart:async';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

Stream getClasses = firebaseFirestore
    .collection('users')
    .doc(uid)
    .collection('classes')
    .orderBy('creationTime', descending: true)
    .snapshots();

Stream getDepartments = firebaseFirestore
    .collection('users')
    .doc(uid)
    .collection('departments')
    .orderBy('creationTime', descending: true)
    .snapshots();

Stream getStudents({required classId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('classes')
      .doc(classId)
      .collection('students')
      .orderBy('registrationNo')
      .snapshots();
}

Stream getTeachers({required departmentId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('departments')
      .doc(departmentId)
      .collection('teachers')
      .orderBy('id')
      .snapshots();
}

Future getStudentsFutureData({required classId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('classes')
      .doc(classId)
      .collection('students')
      .get();
}

Stream getStudentsAttendances({required classId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('classes')
      .doc(classId)
      .collection('attendances')
      .orderBy('creationTime', descending: true)
      .snapshots();
}

Stream getTeachersAttendances({required departmentId}) {
  return firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('departments')
      .doc(departmentId)
      .collection('attendances')
      .orderBy('creationTime', descending: true)
      .snapshots();
}
