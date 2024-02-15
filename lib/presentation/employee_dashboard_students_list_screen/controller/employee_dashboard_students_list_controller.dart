import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/employee_dashboard_students_list_screen/models/employee_dashboard_students_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/student.dart';

class EmployeeDashboardStudentsListController extends GetxController {
  TextEditingController scheduletabController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Student> studentsList = <Student>[].obs;

  TextEditingController editStudentNameController = TextEditingController();
  TextEditingController editStudentEmailController = TextEditingController();
  TextEditingController editStudentClzController = TextEditingController();
  TextEditingController editStudentPhoneController = TextEditingController();
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  late SnackBar snackBar;

  @override
  void onReady() {
    super.onReady();
  }

  //update Student data
  Future<void> updateStudentData(String id) async {
    bool isConnected = await networkInfo.isConnected();
    final userId = id;
    if (isConnected) {
      try {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        await userRef.update({
          'name': editStudentNameController.text,
          'phoneNo': editStudentPhoneController.text,
          'class': editStudentClzController.text,
        });

        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Student Updated successfully.',
          ),
        );
      } catch (e) {
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Student Updating process has failed.',
          ),
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'No internet connection. Please turn on your internet.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Stream<List<Student>> get studentsStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Student(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  clz: doc.data()['class'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  @override
  void onClose() {
    super.onClose();
    scheduletabController.dispose();
  }
}
