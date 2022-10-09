import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_attendence_app/constants/user_constants.dart';

class Department {
  String? department;
  String? organization;
  String? field;
  String? location;
  String? profession;
  int? members;
  DateTime? creationTime;

  Department(
      {required this.department,
      required this.organization,
      required this.field,
      required this.location,
      required this.profession,
      required this.members,
      required this.creationTime});

  factory Department.fromDocument(QueryDocumentSnapshot document) {
    return Department(
        department: document['department'],
        organization: document['organization'],
        field: document['field'],
        location: document['location'],
        profession: document['profession'],
        members: document['members'],
        creationTime: document['creationTime'].toDate());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'department': department,
      'organization': organization,
      'field': field,
      'location': location,
      'profession': profession,
      'members': members,
      'creationTime': dateTime
    };
  }
}
