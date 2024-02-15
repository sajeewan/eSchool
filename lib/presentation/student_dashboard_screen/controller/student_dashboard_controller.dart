import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/student_dashboard_screen/models/student_dashboard_model.dart';

import '../../../data/models/teacher.dart';

class StudentDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Teacher> teachersList = <Teacher>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Teacher>> get teachersStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'teacher')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Teacher(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  subject: doc.data()['subject'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
