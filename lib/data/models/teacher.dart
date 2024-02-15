import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String id;
  final String name;
  final String email;
  final String image;
  final String subject;
  final String phoneNo;
  final String dob;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.subject,
    required this.dob,
    required this.phoneNo,
  });

  static Teacher fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Teacher(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      image: data['image'],
      subject: data['subject'],
      dob: data['dob'],
      phoneNo: data['phoneNo'],
    );
  }
}
