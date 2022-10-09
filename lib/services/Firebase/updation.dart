import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

class Updation {
  updateClassMembersCount(
      {required String classId, required int members}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('classes')
        .doc(classId)
        .update({'members': members});
  }

  updateDepartmentMembersCount(
      {required String departmentId, required int members}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('departments')
        .doc(departmentId)
        .update({'members': members});
  }
}
