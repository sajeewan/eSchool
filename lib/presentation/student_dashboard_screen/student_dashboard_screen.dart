import '../../data/models/teacher.dart';
import '../student_dashboard_screen/widgets/listrectangleone3_item_widget.dart';
import 'controller/student_dashboard_controller.dart';
import 'models/listrectangleone3_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends GetWidget<StudentDashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 43,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgVolume,
                    margin: getMargin(left: 19, top: 53, bottom: 21),
                    onTap: onTapVolume3),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_teachers".tr,
                    margin: getMargin(top: 51, bottom: 22)),
                actions: [
                  Container(
                      height: getSize(25),
                      width: getSize(25),
                      margin:
                          getMargin(left: 23, top: 52, right: 23, bottom: 21),
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
                            onTap: onTapUser2)
                      ]))
                ],
                styleType: Style.bgFillBluegray700),
            body: StreamBuilder<List<Teacher>>(
              stream: controller.teachersStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final teachers = snapshot.data!;
                  if (teachers.length == 0) {
                    return Center(
                      child: Text('No teachers to show.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];
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
                              backgroundImage: NetworkImage(teacher.image),
                            ),
                            title: Text(
                              teacher.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              teacher.subject,
                              textAlign: TextAlign.left,
                            ),
                            onTap: () {},
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
            )));
  }

  onTapVolume3() {
    Get.toNamed(AppRoutes.announcementsListScreen);
  }

  onTapUser2() {
    Get.toNamed(AppRoutes.myProfileScreen);
  }
}
