import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

class Class {
  String? schoolCollege;
  String? semesterSection;
  String? program;
  String? subject;
  String? session;
  int? members;
  DateTime? creationTime;

  Class(
      {required this.schoolCollege,
      required this.semesterSection,
      required this.program,
      required this.subject,
      required this.session,
      required this.members,
      required this.creationTime});

  factory Class.fromDocument(QueryDocumentSnapshot document) {
    return Class(
        schoolCollege: document['schoolCollege'],
        semesterSection: document['semesterSection'],
        program: document['program'],
        subject: document['subject'],
        session: document['session'],
        members: document['members'],
        creationTime: document['creationTime'].toDate());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'schoolCollege': schoolCollege,
      'semesterSection': semesterSection,
      'program': program,
      'subject': subject,
      'session': session,
      'members': members,
      'creationTime': creationTime
    };
  }
}
