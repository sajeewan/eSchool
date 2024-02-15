import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/announcements_list_screen/models/announcements_list_model.dart';

import '../../../data/models/announcement.dart';

class AnnouncementsListController extends GetxController {
  Rx<AnnouncementsListModel> announcementsListModelObj =
      AnnouncementsListModel().obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Announcement> AnnouncementList = <Announcement>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  Stream<List<Announcement>> get announcementStream {
    return _firestore
        .collection('announcements')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Announcement(
                  id: doc.id,
                  title: doc.data()['title'] ?? '',
                  message: doc.data()['message'] ?? '',
                ))
            .toList());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
