import 'dart:io';

import 'package:eschool/widgets/custom_imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_datepicker.dart';
import 'controller/my_profile_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/core/utils/validation_functions.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class MyProfileScreen extends GetWidget<MyProfileController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final MyProfileController controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.blue50,
            body: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        child: Container(
                          margin: getMargin(left: 0),
                          padding: getPadding(top: 20, bottom: 20),
                          decoration: AppDecoration.fillBluegray700.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderBL40),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomAppBar(
                                  height: getVerticalSize(30),
                                  leadingWidth: 60,
                                  leading: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: onTapArrowleft2,
                                  ),
                                  centerTitle: true,
                                  title: AppbarTitle(text: "lbl_profile".tr),
                                  actions: [
                                    controller.role.value != "admin"
                                        ? PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            itemBuilder: (_) => [
                                              PopupMenuItem(
                                                textStyle: TextStyle(
                                                  color: ColorConstant.redA200,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                value: 1,
                                                child:
                                                    Text("Delete my account"),
                                              ),
                                            ],
                                            onSelected: (value) {
                                              if (value == 1) {
                                                onTapDeleteUser(context);
                                              }
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  height: getVerticalSize(100),
                                  width: getHorizontalSize(100),
                                  child: CustomImagePicker(
                                    size: 50,
                                    currentImage: controller
                                        .profilePictureUrl.value
                                        .toString(),
                                    onImageSelected: (File image) {
                                      controller.uploadImage(image);
                                    },
                                  ),
                                ),
                                Padding(
                                    padding: getPadding(top: 8),
                                    child: Text(controller.name.value,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtRalewayBold20)),
                                Padding(
                                  padding: getPadding(top: 4),
                                  child: Text(controller.email.value,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtRalewaySemiBold15),
                                ),
                                Padding(
                                  padding: getPadding(top: 4),
                                  child: Container(
                                    height: 20,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.role.value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: getPadding(left: 49, top: 51),
                          child: Text("lbl_name".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium14),
                        ),
                      ),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: controller.nameController,
                          hintText: "lbl_full_name".tr,
                          margin: getMargin(left: 49, top: 2, right: 47),
                          validator: (value) {
                            if (!isText(value)) {
                              return "Please enter valid text";
                            }
                            return null;
                          }),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 49, top: 18),
                              child: Text("lbl_email".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium14))),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: controller.emailController,
                          hintText: "lbl_email_address".tr,
                          enabled: false,
                          margin: getMargin(left: 49, top: 2, right: 47),
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                (!isValidEmail(value, isRequired: true))) {
                              return "Please enter valid email";
                            }
                            return null;
                          }),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 49, top: 15),
                              child: Text("lbl_phone_number".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium14))),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: controller.phoneNoController,
                          hintText: "lbl_phone_number".tr,
                          margin: getMargin(left: 49, top: 5, right: 47),
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (!isValidPhone(value)) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          }),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 49, top: 18),
                              child: Text("lbl_date_of_birth".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsMedium14))),
                      Container(
                        margin: getMargin(left: 49, top: 2, right: 47),
                        child: CustomDatePicker(
                          textEditingController: controller.dobController,
                        ),
                      ),
                      CustomButton(
                        height: getVerticalSize(40),
                        width: getHorizontalSize(283),
                        text: "lbl_update".tr,
                        margin: getMargin(top: 30),
                        onTap: () => onTapUpdate(context),
                      ),
                      CustomButton(
                          height: getVerticalSize(40),
                          width: getHorizontalSize(283),
                          text: "lbl_change_password".tr,
                          margin: getMargin(top: 9, bottom: 9),
                          onTap: onTapChangepassword),
                      CustomButton(
                          height: getVerticalSize(40),
                          width: getHorizontalSize(283),
                          text: "lbl_logout".tr,
                          margin: getMargin(left: 67, right: 64, bottom: 34),
                          variant: ButtonVariant.FillRedA200,
                          onTap: onTapLogout),
                    ]),
              ),
            ),
          ),
        ));
  }

  onTapArrowleft2() {
    Get.back();
  }

  void onTapUpdate(context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      await controller.updateUserData();
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(controller.snackBar);
  }

  void onTapDeleteUser(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Delete user Account!",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: const Text(
                "Do you really want to delete your account? It cannot be restored once it has been deleted."),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await controller.deleteAndLogoutUser();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(controller.snackBar);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    Get.offAllNamed(AppRoutes.splashScreen);
                  },
                  child: const Text("DELETE")),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("CANCEL"),
              ),
            ],
          );
        });
  }

  onTapChangepassword() {
    Get.toNamed(AppRoutes.passwordChangeScreen);
  }

  void onTapLogout() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.splashScreen);
  }
}
