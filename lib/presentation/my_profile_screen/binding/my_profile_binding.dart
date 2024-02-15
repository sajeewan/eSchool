import '../controller/my_profile_controller.dart';
import 'package:get/get.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyProfileController());
  }
}
