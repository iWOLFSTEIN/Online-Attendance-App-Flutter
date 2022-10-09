import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? name;
  String? registrationNo;

  Student({required this.name, required this.registrationNo});

  factory Student.fromDocument(QueryDocumentSnapshot document) {
    return Student(
        name: document['name'], registrationNo: document['registrationNo']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'registrationNo': registrationNo,
    };
  }
}
