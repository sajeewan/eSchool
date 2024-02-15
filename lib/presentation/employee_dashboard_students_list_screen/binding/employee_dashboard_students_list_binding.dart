import '../controller/employee_dashboard_students_list_controller.dart';
import 'package:get/get.dart';

class EmployeeDashboardStudentsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDashboardStudentsListController());
  }
}
