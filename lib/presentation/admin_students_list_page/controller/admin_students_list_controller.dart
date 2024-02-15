import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_students_list_page/models/admin_students_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/student.dart';

class AdminStudentsListController extends GetxController {
  TextEditingController editStudentNameController = TextEditingController();
  TextEditingController editStudentEmailController = TextEditingController();
  TextEditingController editStudentClzController = TextEditingController();
  TextEditingController editStudentPhoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  late SnackBar snackBar;
  RxList<Student> studentsList = <Student>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  //update Student data
  Future<void> updateStudentData(String userId) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final userRef = _firestore.collection('users').doc(userId);

        await userRef.update({
          'name': editStudentNameController.text,
          'phoneNo': editStudentPhoneController.text,
          'class': editStudentClzController.text,
        });

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Student updated successfully.',
          ),
        );
      } catch (e) {
        // Show error message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Error while updating student',
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

  //list of students
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

  Future<void> deleteStudent(String studentId) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Delete user from users collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(studentId)
            .delete();

        // Remove user from local list
        studentsList.removeWhere((student) => student.id == studentId);

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Student deleted successfully.',
          ),
        );
      } catch (e) {
        // Show error message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Error while deleting Student',
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

  @override
  void onClose() {
    super.onClose();
  }
}
