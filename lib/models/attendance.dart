import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  DateTime? creationTime;
  Map? attendance;

  Attendance({
    required this.attendance,
    required this.creationTime,
  });

  factory Attendance.fromDocument(QueryDocumentSnapshot document) {
    return Attendance(
      creationTime: document['creationTime'].toDate(),
      attendance: document['attendance'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationTime': creationTime,
      'attendance': attendance,
    };
  }
}
