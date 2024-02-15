import 'dart:io';

import 'package:eschool/widgets/custom_imagepicker.dart';

import '../../data/models/teacher.dart';
import '../../widgets/custom_button.dart';
import '../admin_teachers_list_page/widgets/listrectangleone4_item_widget.dart';
import 'controller/admin_teachers_list_controller.dart';
import 'models/admin_teachers_list_model.dart';
import 'models/listrectangleone4_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class AdminTeachersListPage extends StatelessWidget {
  final AdminTeachersListController controller =
      Get.put(AdminTeachersListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<List<Teacher>>(
            stream: controller.teachersStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final teachers = snapshot.data!;
                if (teachers.length == 0) {
                  return Center(
                    child: Text('No teachers added yet.'),
                  );
                }
                return ListView.builder(
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];
                    return Dismissible(
                        background: Container(
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.red.shade100,
                          child: Icon(
                            Icons.delete,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                        key: UniqueKey(),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) async {
                          await controller.deleteTeacher(teacher.id);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(controller.snackBar);
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this teacher?"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
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
                              onTap: () => _showTeacherModalBottomSheet(
                                  context, teacher),
                            ),
                          ),
                        ));
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
      ),
    );
  }

  void _showTeacherModalBottomSheet(BuildContext context, teacher) {
    controller.editTeacherNameController.text = teacher.name;
    controller.editTeacherEmailController.text = teacher.email;
    controller.editTeacherPhoneController.text = teacher.phoneNo;
    controller.editTeacherSubjectController.text = teacher.subject;
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
                    'Edit Teacher',
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
                        backgroundImage: NetworkImage(teacher.image),
                        radius: 50,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.editTeacherNameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editTeacherEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: false,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editTeacherPhoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editTeacherSubjectController,
                    decoration: InputDecoration(labelText: 'Subject'),
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                      height: getVerticalSize(45),
                      text: "lbl_save".tr,
                      margin: getMargin(left: 42, top: 50, right: 42),
                      fontStyle: ButtonFontStyle.RalewayBold20,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        await controller.updateTeacherData(teacher.id);
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
}
