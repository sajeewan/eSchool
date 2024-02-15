import '../controller/teacher_dasboard_controller.dart';
import 'package:get/get.dart';

class TeacherDasboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherDasboardController());
  }
}
