import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String id;
  final String name;
  final String email;
  final String image;
  final String phoneNo;
  final String dob;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.dob,
    required this.phoneNo,
  });

  static Employee fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Employee(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      image: data['image'],
      dob: data['dob'],
      phoneNo: data['phoneNo'],
    );
  }
}
