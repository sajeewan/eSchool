import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_employee_screen/models/add_employee_model.dart';
import 'package:eschool/core/network/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmployeeController extends GetxController {
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeEmailController = TextEditingController();
  TextEditingController employeeDobController = TextEditingController();
  TextEditingController employeePhoneController = TextEditingController();

  Rx<AddEmployeeModel> addEmployeeModelObj = AddEmployeeModel().obs;
  late SnackBar snackBar;

  String? imageUrl = "";

  void uploadEmployeeImage(File image) {
    uploadImageToStorage(image);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());

  Future<void> uploadImageToStorage(File imageFile) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = _storage.ref().child('profile/$fileName');
        UploadTask uploadTask = reference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrl = downloadUrl;
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error while creating employee.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
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

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> createEmployeeAccount() async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Create the user account using Firebase Authentication
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: employeeEmailController.text,
          password: employeePhoneController.text,
        );

        if (imageUrl == "") {
          imageUrl =
              'https://firebasestorage.googleapis.com/v0/b/eschool-950d4.appspot.com/o/profile%2Fdefault_user.png?alt=media&token=47e2f4f3-53cf-49f1-ae7f-5810c8933265';
        }

        // Store the user profile information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': employeeNameController.text,
          'email': employeeEmailController.text,
          'phoneNo': employeePhoneController.text,
          'dob': employeeDobController.text,
          'role': 'employee',
          'image': imageUrl
        });

        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Employee added successfully.',
          ),
        );

        imageUrl = "";
        employeeNameController.clear();
        employeeEmailController.clear();
        employeeDobController.clear();
        employeePhoneController.clear();
      } on FirebaseAuthException catch (e) {
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Employee adding process has failed.',
          ),
        );

        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: '${e.message}',
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
    imageUrl = "";
    employeeNameController.dispose();
    employeeEmailController.dispose();
    employeeDobController.dispose();
    employeePhoneController.dispose();
  }
}
