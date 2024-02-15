import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/password_change_screen/models/password_change_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordChangeController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late SnackBar snackBar;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());

  Rx<PasswordChangeModel> passwordChangeModelObj = PasswordChangeModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> changePassword() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    bool isConnected = await networkInfo.isConnected();

    // Get credentials for reauthentication
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPasswordController.text,
    );

    if (isConnected) {
      try {
        // Reauthenticate user with current password
        await user.reauthenticateWithCredential(credential);

        // Change password
        await user.updatePassword(newPasswordController.text);

        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Password updated successfully.',
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.failure,
              title: 'Oh, oh!',
              message: 'Wrong password. Try again.',
            ),
          );
        } else {
          snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.failure,
              title: 'Oh, oh!',
              message: 'Oh oh!. Something went wrong',
            ),
          );
        }
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
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}
