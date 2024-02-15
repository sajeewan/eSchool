import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_students_list_tab_container_screen/models/admin_students_list_tab_container_model.dart';
import 'package:flutter/material.dart';

class AdminStudentsListTabContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<AdminStudentsListTabContainerModel> adminStudentsListTabContainerModelObj =
      AdminStudentsListTabContainerModel().obs;

  late TabController tabbarvariant3Controller =
      Get.put(TabController(vsync: this, length: 3));




  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
  }
}
