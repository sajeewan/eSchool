import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final String email;
  final String image;
  final String clz;
  final String phoneNo;
  final String dob;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.clz,
    required this.dob,
    required this.phoneNo,
  });

  static Student fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Student(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      image: data['image'],
      clz: data['class'],
      dob: data['dob'],
      phoneNo: data['phoneNo'],
    );
  }
}
