import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/announcements_screen/models/announcements_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AnnouncementsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Rx<AnnouncementsModel> announcementsModelObj = AnnouncementsModel().obs;
  final NetworkInfoI networkInfo = NetworkInfo(Connectivity());

  Future<void> createAnnouncement() async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        await FirebaseFirestore.instance.collection('announcements').doc().set({
          'title': titleController.text,
          'message': messageController.text,
        });

        Fluttertoast.showToast(
          msg: 'Announcement added successfully.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Oh, oh! Something went wrong.',
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    messageController.dispose();
  }
}
