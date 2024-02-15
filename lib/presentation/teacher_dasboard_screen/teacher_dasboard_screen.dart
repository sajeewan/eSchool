import 'dart:io';

import '../../data/models/student.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_imagepicker.dart';
import '../teacher_dasboard_screen/widgets/listrectangleone2_item_widget.dart';
import 'controller/teacher_dasboard_controller.dart';
import 'models/listrectangleone2_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

class TeacherDasboardScreen extends GetWidget<TeacherDasboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 40,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 16, top: 53, bottom: 21),
                    onTap: onTapVolume2),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_students".tr,
                    margin: getMargin(top: 51, bottom: 22)),
                actions: [
                  Container(
                      height: getSize(25),
                      width: getSize(25),
                      margin:
                          getMargin(left: 26, top: 52, right: 26, bottom: 21),
                      child: Stack(alignment: Alignment.center, children: [
                        AppbarImage(
                            height: getSize(9),
                            width: getSize(9),
                            svgPath: ImageConstant.imgSettings,
                            margin: getMargin(
                                left: 7, top: 4, right: 8, bottom: 11)),
                        AppbarImage(
                            height: getSize(25),
                            width: getSize(25),
                            svgPath: ImageConstant.imgUser,
                            onTap: onTapUser1)
                      ]))
                ],
                styleType: Style.bgFillBluegray700),
            body: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<List<Student>>(
                stream: controller.studentsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final students = snapshot.data!;
                    if (students.length == 0) {
                      return Center(
                        child: Text('No students added yet.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 2),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blueGrey.shade700,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(student.image),
                              ),
                              title: Text(
                                student.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                student.clz,
                                textAlign: TextAlign.left,
                              ),
                              onTap: () {
                                _showTeacherModalBottomSheet(context, student);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching teachers'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            floatingActionButton: CustomFloatingButton(
                height: 44,
                width: 44,
                onTap: () {
                  onTapBtnFloatingactionbutton();
                },
                child: CustomImageView(
                    svgPath: ImageConstant.imgPlus,
                    height: getVerticalSize(22.0),
                    width: getHorizontalSize(22.0)))));
  }

  void _showTeacherModalBottomSheet(BuildContext context, student) {
    controller.editStudentNameController.text = student.name;
    controller.editStudentEmailController.text = student.email;
    controller.editStudentPhoneController.text = student.phoneNo;
    controller.editStudentClzController.text = student.clz;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Student',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(105),
                      width: getHorizontalSize(100),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(student.image),
                        radius: 50,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.editStudentNameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editStudentEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: false,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editStudentPhoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editStudentClzController,
                    decoration: InputDecoration(labelText: 'Class'),
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                      height: getVerticalSize(45),
                      text: "lbl_save".tr,
                      margin: getMargin(left: 42, top: 50, right: 42),
                      fontStyle: ButtonFontStyle.RalewayBold20,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        await controller.updateStudentData(student.id);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(controller.snackBar);
                        Navigator.pop(context);
                      }),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          );
        });
  }

  onTapBtnFloatingactionbutton() {
    Get.toNamed(AppRoutes.addStudentScreen);
  }

  onTapVolume2() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }

  onTapUser1() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
