import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/my_profile_screen/models/my_profile_model.dart';

class MyProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Rx<MyProfileModel> myProfileModelObj = MyProfileModel().obs;
  late SnackBar snackBar;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());
  late SharedPreferences prefs;

  RxString id = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNo = "".obs;
  RxString dob = "".obs;
  RxString profilePictureUrl = "".obs;
  RxString role = "".obs;

  String imageUrl = "";

  void uploadImage(File image) {
    uploadImageToStorage(image);
  }

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString("user_id") ?? "";
    name.value = prefs.getString("user_name") ?? "";
    phoneNo.value = prefs.getString("user_phoneNo") ?? "";
    dob.value = prefs.getString("user_dob") ?? "";
    email.value = prefs.getString("user_email") ?? "";
    profilePictureUrl.value = prefs.getString("user_image") ?? "";
    role.value = prefs.getString("user_role") ?? "";

    nameController = TextEditingController(text: name.value);
    emailController = TextEditingController(text: email.value);
    phoneNoController = TextEditingController(text: phoneNo.value);
    dobController = TextEditingController(text: dob.value);
    imageUrl = profilePictureUrl.value;
  }

  //upload image
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

  //update user data
  Future<void> updateUserData() async {
    prefs = await SharedPreferences.getInstance();
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(id.value);
        await userRef.update({
          'name': nameController.text,
          'phoneNo': phoneNoController.text,
          'dob': dobController.text,
          'image': imageUrl
        });
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Success',
            message: 'Profile updated successfully.',
          ),
        );

        //set shared prefference values
        prefs.setString("user_name", nameController.text);
        prefs.setString("user_phoneNo", phoneNoController.text);
        prefs.setString("user_dob", dobController.text);
        prefs.setString("user_image", imageUrl);
      } on FirebaseAuthException catch (e) {
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oh, oh!',
            message: 'Profile updating process has failed.:',
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

  //delete user account
  Future<void> deleteAndLogoutUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (id.value != null) {
      try {
        // Delete user document from Firestore users collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id.value)
            .delete();

        // Delete user account from Firebase Authentication
        // await currentUser.delete();

        // Show success message and redirect to login screen
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Account deleted',
            message: 'Your account has been successfully deleted.',
          ),
        );
        // Log out user
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        // Show error message
        snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Error',
            message: 'An error occurred while deleting your account: $e',
          ),
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    dobController.dispose();
  }
}
