import 'dart:io';

import 'package:eschool/data/models/employee.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_imagepicker.dart';
import '../admin_employee_list_page/widgets/listrectangleone6_item_widget.dart';
import 'controller/admin_employee_list_controller.dart';
import 'models/admin_employee_list_model.dart';
import 'models/listrectangleone6_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminEmployeeListPage extends StatelessWidget {
  AdminEmployeeListController controller =
      Get.put(AdminEmployeeListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<List<Employee>>(
            stream: controller.employeeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final employees = snapshot.data!;
                if (employees.length == 0) {
                  return Center(
                    child: Text('No employees added yet.'),
                  );
                }
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
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
                        await controller.deleteEmployee(employee.id);
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
                              backgroundImage: NetworkImage(employee.image),
                            ),
                            title: Text(
                              employee.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              employee.phoneNo,
                              textAlign: TextAlign.left,
                            ),
                            onTap: () {
                              _showTeacherModalBottomSheet(context, employee);
                            },
                          ),
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
      ),
    );
  }

  void _showTeacherModalBottomSheet(BuildContext context, employee) {
    controller.editEmployeeNameController.text = employee.name;
    controller.editEmployeeEmailController.text = employee.email;
    controller.editEmployeePhoneController.text = employee.phoneNo;
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
                    'Edit Employee',
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
                        backgroundImage: NetworkImage(employee.image),
                        radius: 50,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.editEmployeeNameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editEmployeeEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: false,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controller.editEmployeePhoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                      height: getVerticalSize(45),
                      text: "lbl_save".tr,
                      margin: getMargin(left: 42, top: 50, right: 42),
                      fontStyle: ButtonFontStyle.RalewayBold20,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        controller.updateEmployeeData(employee.id);
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
