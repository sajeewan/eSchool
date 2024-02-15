import '../controller/add_teacher_controller.dart';
import 'package:get/get.dart';

class AddTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTeacherController());
  }
}
