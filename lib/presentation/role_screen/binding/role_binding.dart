import '../controller/role_controller.dart';
import 'package:get/get.dart';

class RoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoleController());
  }
}
