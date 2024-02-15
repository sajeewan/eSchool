import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/splash_screen/models/splash_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _isSignedIn = false.obs;
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  late ConnectivityResult _connectivityResult;
  late SnackBar snackBar;

  @override
  void onReady() {
    super.onReady();
    checkInternet();
  }

  Future<void> checkInternet() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    if (_connectivityResult != ConnectivityResult.none) {
      checkAuth();
    } else {
      // internet is not available
      Fluttertoast.showToast(
        msg: 'No internet connection. Please turn on your internet.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Connectivity().onConnectivityChanged.firstWhere((result) {
        if (result == ConnectivityResult.none) {
          return false;
        } else {
          return true;
        }
      });

      checkAuth();
    }
  }

  void checkAuth() {
    // Wait until the authentication process finishes
    User? user = _auth.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Get.offNamed(AppRoutes.roleScreen);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final user_role = prefs.getString('user_role').toString();
        if (user_role == 'admin') {
          Get.offNamed(AppRoutes.adminStudentsListTabContainerScreen);
        } else if (user_role == 'teacher') {
          Get.offNamed(AppRoutes.teacherDasboardScreen);
        } else if (user_role == 'student') {
          Get.offNamed(AppRoutes.studentDashboardScreen);
        } else if (user_role == 'employee') {
          Get.offNamed(AppRoutes.employeeTabContainerScreen);
        }
        // else {
        //   await _auth.signOut();
        //   Get.offAllNamed(AppRoutes.roleScreen);
        // }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
