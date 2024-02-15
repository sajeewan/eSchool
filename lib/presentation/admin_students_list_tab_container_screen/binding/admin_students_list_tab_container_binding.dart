import '../controller/admin_students_list_tab_container_controller.dart';
import 'package:get/get.dart';

class AdminStudentsListTabContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminStudentsListTabContainerController());
  }
}
