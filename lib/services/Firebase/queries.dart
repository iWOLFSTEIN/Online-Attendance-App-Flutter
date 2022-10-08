import 'dart:async';

import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

Stream getClasses = firebaseFirestore
    .collection('users')
    .doc(uid)
    .collection('classes')
    .snapshots();
