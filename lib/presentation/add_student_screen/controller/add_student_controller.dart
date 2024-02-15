import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_student_screen/models/add_student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStudentController extends GetxController {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentPhoneController = TextEditingController();
  TextEditingController studentDobController = TextEditingController();
  TextEditingController studentClassController = TextEditingController();

  Rx<AddStudentModel> addStudentModelObj = AddStudentModel().obs;
  late SnackBar snackBar;

  String? imageUrl = "";
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());

  @override
  void onReady() {
    super.onReady();
  }

  void uploadStudentImage(File image) {
    uploadImageToStorage(image);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
          msg: 'Error while uploading image.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
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

  Future<void> createStudentAccount() async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Create the user account using Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: studentEmailController.text,
          password: studentPhoneController.text,
        );

        //default image
        if (imageUrl == "") {
          imageUrl =
              'https://firebasestorage.googleapis.com/v0/b/eschool-950d4.appspot.com/o/profile%2Fdefault_user.png?alt=media&token=47e2f4f3-53cf-49f1-ae7f-5810c8933265';
        }

        // Store the user profile information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': studentNameController.text,
          'email': studentEmailController.text,
          'phoneNo': studentPhoneController.text,
          'dob': studentDobController.text,
          'role': 'student',
          'class': studentClassController.text,
          'image': imageUrl
        });
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Student added successfully.',
          ),
        );

        imageUrl = "";
        studentNameController.clear();
        studentEmailController.clear();
        studentPhoneController.clear();
        studentDobController.clear();
        studentClassController.clear();
      } on FirebaseAuthException catch (e) {
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Student adding process has failed.',
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
    studentNameController.dispose();
    studentEmailController.dispose();
    studentPhoneController.dispose();
    studentDobController.dispose();
    studentClassController.dispose();
  }
}
