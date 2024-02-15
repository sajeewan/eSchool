import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

import '../models/employee_tab_container_model.dart';

class EmployeeTebContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabbarvariant3Controller =
      Get.put(TabController(vsync: this, length: 2));

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
