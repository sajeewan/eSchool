import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_teachers_list_page/models/admin_teachers_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/teacher.dart';

class AdminTeachersListController extends GetxController {
  // AdminTeachersListController(this.adminTeachersListModelObj);
  // Rx<AdminTeachersListModel> adminTeachersListModelObj;

  TextEditingController editTeacherNameController = TextEditingController();
  TextEditingController editTeacherEmailController = TextEditingController();
  TextEditingController editTeacherSubjectController = TextEditingController();
  TextEditingController editTeacherPhoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  late SnackBar snackBar;
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

  Future<void> deleteTeacher(String teacherId) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Delete user from Firebase Authentication

        // Delete user from users collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(teacherId)
            .delete();

        // Remove teacher from local list
        teachersList.removeWhere((teacher) => teacher.id == teacherId);

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Teacher deleted successfully.',
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
            message: 'Error while deleting teacher',
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

  //update Teacher data
  Future<void> updateTeacherData(userId) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final userRef = _firestore.collection('users').doc(userId);

        await userRef.update({
          'name': editTeacherNameController.text,
          'phoneNo': editTeacherPhoneController.text,
          'subject': editTeacherSubjectController.text,
        });

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Teacher updated successfully.',
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
            message: 'Error while updating teacher',
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
