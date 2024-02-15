import '../controller/announcements_list_controller.dart';
import 'package:get/get.dart';

class AnnouncementsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementsListController());
  }
}
