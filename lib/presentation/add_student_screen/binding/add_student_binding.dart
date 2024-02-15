import '../controller/add_student_controller.dart';
import 'package:get/get.dart';

class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStudentController());
  }
}
