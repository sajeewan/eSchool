import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/add_teacher_screen/models/add_teacher_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTeacherController extends GetxController {
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherEmailController = TextEditingController();
  TextEditingController teacherPhoneController = TextEditingController();
  TextEditingController teacherDobController = TextEditingController();
  TextEditingController teacherSubjectController = TextEditingController();
  Rx<AddTeacherModel> addTeacherModelObj = AddTeacherModel().obs;
  late SnackBar snackBar;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  String? imageUrl = "";

  @override
  void onReady() {
    super.onReady();
  }

  void uploadTeacherImage(File image) {
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
          msg: 'Error while uploading image',
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

  Future<void> createTeacherAccount() async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        // Create the user account using Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: teacherEmailController.text,
          password: teacherPhoneController.text,
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
          'name': teacherNameController.text,
          'email': teacherEmailController.text.trim(),
          'phoneNo': teacherPhoneController.text,
          'dob': teacherDobController.text,
          'role': 'teacher',
          'subject': teacherSubjectController.text,
          'image': imageUrl
        });
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Teacher added successfully.',
          ),
        );

        imageUrl = "";
        teacherEmailController.clear();
        teacherNameController.clear();
        teacherPhoneController.clear();
        teacherDobController.clear();
        teacherSubjectController.clear();
      } on FirebaseAuthException catch (e) {
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Teacher adding process has failed.',
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
    teacherEmailController.dispose();
    teacherNameController.dispose();
    teacherPhoneController.dispose();
    teacherDobController.dispose();
    teacherSubjectController.dispose();
  }
}
