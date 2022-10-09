import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/attendance.dart';
import 'package:online_attendence_app/models/class.dart';
import 'package:online_attendence_app/models/department.dart';
import 'package:online_attendence_app/models/student.dart';
import 'package:online_attendence_app/models/teacher.dart';

class Creation {
  createClass({
    required Class classModel,
  }) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('classes')
        .add(classModel.toMap());
  }

  createDepartment({required Department departmentModel}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('departments')
        .add(departmentModel.toMap());
  }

  addStudent({required Student studentModel, required String classId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('classes')
        .doc(classId)
        .collection('students')
        .add(studentModel.toMap());
  }

  addTeacher(
      {required Teacher teacherModel, required String departmentId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('departments')
        .doc(departmentId)
        .collection('teachers')
        .add(teacherModel.toMap());
  }

  createClassAttendance(
      {required Attendance attendanceModel, required String classId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('classes')
        .doc(classId)
        .collection('attendances')
        .add(attendanceModel.toMap());
  }
}
