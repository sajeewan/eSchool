import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eschool/presentation/sign_in_screen/models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailvalueController = TextEditingController();
  TextEditingController passwordvalueController = TextEditingController();
  late SnackBar snackBar;
  var isNotVisible = true.obs;
  Rx<SignInModel> signInModelObj = SignInModel().obs;

  @override
  void onReady() {
    super.onReady();
    isNotVisible.value = true;
  }

  Future<void> signInUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailvalueController.text,
        password: passwordvalueController.text,
      );
      if (userCredential.user != null) {
        // Store the user profile data in shared preferences
        await storeUserProfileData(userCredential.user!.uid);

        // Fetch the user role from Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .get();
        final String userRole = snapshot.data()!['role'];

        // Navigate to the proper screen based on the user role
        if (userRole == 'admin') {
          Get.offNamed(AppRoutes.adminStudentsListTabContainerScreen);
        } else if (userRole == 'teacher') {
          Get.offNamed(AppRoutes.teacherDasboardScreen);
        } else if (userRole == 'student') {
          Get.offNamed(AppRoutes.studentDashboardScreen);
        } else if (userRole == 'employee') {
          Get.offNamed(AppRoutes.employeeTabContainerScreen);
        } else {
          FirebaseAuth.instance.signOut();
          snackBar = SnackBar(
            content: Text("User account was deleted, Pleae contact the admin"),
            duration: new Duration(seconds: 2),
            backgroundColor: Colors.red,
          );
        }
        snackBar = SnackBar(
          content: Text("Login Successfull!"),
          duration: new Duration(seconds: 2),
          backgroundColor: Colors.green,
        );
      }
    } on FirebaseAuthException catch (error) {
      snackBar = SnackBar(
        content: Text("${error.message}"),
        duration: new Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> storeUserProfileData(String userId) async {
    try {
      // Fetch user profile data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      // Store the user profile data in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', userDoc.id);
      prefs.setString('user_name', userDoc.data()!['name']);
      prefs.setString('user_email', userDoc.data()!['email']);
      prefs.setString('user_role', userDoc.data()!['role']);
      prefs.setString('user_phoneNo', userDoc.data()!['phoneNo']);
      prefs.setString('user_dob', userDoc.data()!['dob']);
      prefs.setString('user_image', userDoc.data()!['image']);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Oh, oh! something went wrong.',
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
  void dispose() {
    emailvalueController.dispose();
    passwordvalueController.dispose();
    super.dispose();
  }
}
