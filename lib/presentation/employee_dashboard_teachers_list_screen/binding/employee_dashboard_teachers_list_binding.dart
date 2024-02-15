import '../controller/employee_dashboard_teachers_list_controller.dart';
import 'package:get/get.dart';

class EmployeeDashboardTeachersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDashboardTeachersListController());
  }
}
