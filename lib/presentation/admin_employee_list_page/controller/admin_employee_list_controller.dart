import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_employee_list_page/models/admin_employee_list_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/employee.dart';

class AdminEmployeeListController extends GetxController {
  TextEditingController editEmployeeNameController = TextEditingController();
  TextEditingController editEmployeeEmailController = TextEditingController();
  TextEditingController editEmployeePhoneController = TextEditingController();
  late SnackBar snackBar;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Employee> employeeList = <Employee>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Employee>> get employeeStream {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'employee')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Employee(
                  id: doc.id,
                  name: doc.data()['name'] ?? '',
                  email: doc.data()['email'] ?? '',
                  image: doc.data()['image'] ?? '',
                  dob: doc.data()['dob'] ?? '',
                  phoneNo: doc.data()['phoneNo'] ?? '',
                ))
            .toList());
  }

  Future<void> deleteEmployee(String employeeId) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Delete user from users collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(employeeId)
            .delete();

        // Remove user from local list
        employeeList.removeWhere((employee) => employee.id == employeeId);

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Employee delete successfully.',
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
            message: 'Error while deleting employee',
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

  //update Employee data
  Future<void> updateEmployeeData(String id) async {
    bool isConnected = await networkInfo.isConnected();
    final userId = id;
    if (isConnected) {
      try {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        await userRef.update({
          'name': editEmployeeNameController.text,
          'phoneNo': editEmployeePhoneController.text,
        });

        // Show success message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Employee updated successfully.',
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
            message: 'Error while update employee',
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
