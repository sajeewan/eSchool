import '../controller/password_change_controller.dart';
import 'package:get/get.dart';

class PasswordChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordChangeController());
  }
}
