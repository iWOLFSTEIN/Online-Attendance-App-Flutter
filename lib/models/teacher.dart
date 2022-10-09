import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  String? name;
  String? id;

  Teacher({required this.name, required this.id});

  factory Teacher.fromDocument(QueryDocumentSnapshot document) {
    return Teacher(name: document['name'], id: document['id']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }
}
