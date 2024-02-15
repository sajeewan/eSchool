import 'package:eschool/core/app_export.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/employee_tab_container_controller.dart';

class EmployeeTabContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeTebContainerController());
  }
}
