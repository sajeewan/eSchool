import 'package:simple_speed_dial/simple_speed_dial.dart';

import 'controller/admin_students_list_tab_container_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/presentation/admin_employee_list_page/admin_employee_list_page.dart';
import 'package:eschool/presentation/admin_students_list_page/admin_students_list_page.dart';
import 'package:eschool/presentation/admin_teachers_list_page/admin_teachers_list_page.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

class AdminStudentsListTabContainerScreen
    extends GetWidget<AdminStudentsListTabContainerController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 60,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgPlusWhiteA700,
                    margin: getMargin(left: 6, top: 47, bottom: 27),
                    onTap: onTapPlus),
                centerTitle: true,
                title: AppbarTitle(text: "lbl_dashboard".tr),
                actions: [
                  AppbarImage(
                      height: getSize(25),
                      width: getSize(60),
                      svgPath: ImageConstant.imgUserWhiteA700,
                      margin: getMargin(left: 7, top: 47, right: 7, bottom: 26),
                      onTap: onTapUser3)
                ],
                styleType: Style.bgFillBluegray700),
            body: Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: getVerticalSize(37),
                          width: getHorizontalSize(363),
                          margin: getMargin(top: 12),
                          child: TabBar(
                              controller: controller.tabbarvariant3Controller,
                              labelColor: ColorConstant.whiteA700,
                              labelStyle: TextStyle(
                                  fontSize: getFontSize(14),
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600),
                              unselectedLabelColor: ColorConstant.gray900,
                              unselectedLabelStyle: TextStyle(
                                  fontSize: getFontSize(14),
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600),
                              indicator: BoxDecoration(
                                  color: ColorConstant.blueGray700,
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(5)),
                                  border: Border.all(
                                      color: ColorConstant.black90019,
                                      width: getHorizontalSize(1))),
                              tabs: [
                                Tab(
                                    child: Text("lbl_teacher".tr,
                                        overflow: TextOverflow.ellipsis)),
                                Tab(
                                    child: Text("lbl_student".tr,
                                        overflow: TextOverflow.ellipsis)),
                                Tab(
                                    child: Text("lbl_employee".tr,
                                        overflow: TextOverflow.ellipsis))
                              ])),
                      Container(
                          height: getVerticalSize(749),
                          child: TabBarView(
                              controller: controller.tabbarvariant3Controller,
                              children: [
                                AdminTeachersListPage(),
                                AdminStudentsListPage(),
                                AdminEmployeeListPage()
                              ]))
                    ])),
            floatingActionButton: SpeedDial(
              speedDialChildren: [
                SpeedDialChild(
                    child: const Icon(Icons.book),
                    foregroundColor: Colors.white,
                    label: "lbl_teacher".tr,
                    backgroundColor: ColorConstant.blueGray700,
                    onPressed: () {
                      onTapFloatingactionbuttonTeacher();
                    }),
                SpeedDialChild(
                    child: const Icon(Icons.school),
                    foregroundColor: Colors.white,
                    label: "lbl_student".tr,
                    backgroundColor: ColorConstant.blueGray700,
                    onPressed: () {
                      onTapFloatingactionbuttonStudent();
                    }),
                SpeedDialChild(
                    child: const Icon(Icons.person),
                    foregroundColor: Colors.white,
                    label: "lbl_employee".tr,
                    backgroundColor: ColorConstant.blueGray700,
                    onPressed: () {
                      onTapFloatingactionbuttonEmpoyee();
                    }),
              ],
              child: const Icon(Icons.add),
              closedForegroundColor: Colors.white,
              openForegroundColor: Colors.white,
              closedBackgroundColor: Color(0xff275878),
              openBackgroundColor: Color(0xff4c8cb7),
            )));
  }

  onTapFloatingactionbuttonTeacher() {
    Get.toNamed(AppRoutes.addTeacherScreen);
  }

  onTapFloatingactionbuttonStudent() {
    Get.toNamed(AppRoutes.addStudentScreen);
  }

  onTapFloatingactionbuttonEmpoyee() {
    Get.toNamed(AppRoutes.addEmployeeScreen);
  }

  onTapPlus() {
    Get.toNamed(AppRoutes.announcementsScreen);
  }

  onTapUser3() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
