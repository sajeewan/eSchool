import '../controller/student_dashboard_controller.dart';
import 'package:get/get.dart';

class StudentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentDashboardController());
  }
}
