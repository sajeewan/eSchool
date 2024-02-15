import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  final String title;
  final String message;

  Announcement({
    required this.id,
    required this.title,
    required this.message,
  });

  static Announcement fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Announcement(
      id: snapshot.id,
      title: data['title'],
      message: data['message'],
    );
  }
}
