import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/class.dart';

class Deletion {
  deleteClass({required classId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('classes')
        .doc(classId)
        .delete();
  }
}
