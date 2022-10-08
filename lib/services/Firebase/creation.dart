import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';
import 'package:online_attendence_app/models/class.dart';

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
}
