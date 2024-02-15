import 'controller/password_change_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/core/utils/validation_functions.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class PasswordChangeScreen extends GetWidget<PasswordChangeController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.blue50,
        appBar: CustomAppBar(
            height: getVerticalSize(98),
            leadingWidth: 60,
            leading: AppbarImage(
                height: getVerticalSize(17),
                width: getHorizontalSize(30),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 30, top: 54, bottom: 27),
                onTap: onTapArrowleft4),
            title: AppbarTitle(
                text: "lbl_password_change".tr,
                margin: getMargin(left: 77, top: 55, bottom: 18)),
            styleType: Style.bgFillBluegray700),
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: getPadding(left: 48, top: 114, right: 48),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("msg_current_password".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium14),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      controller: controller.currentPasswordController,
                      hintText: "msg_current_password".tr,
                      textInputAction: TextInputAction.next,
                      margin: getMargin(top: 2),
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid password";
                        }
                        return null;
                      },
                      isObscureText: true),
                  Padding(
                      padding: getPadding(top: 27),
                      child: Text("lbl_new_password".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium14)),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      controller: controller.newPasswordController,
                      hintText: "lbl_new_password".tr,
                      margin: getMargin(top: 2),
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid password";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters long.";
                        }
                        return null;
                      },
                      isObscureText: true),
                  Padding(
                      padding: getPadding(top: 27),
                      child: Text("msg_confirm_new_password".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium14)),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      controller: controller.confirmPasswordController,
                      hintText: "msg_confirm_password".tr,
                      margin: getMargin(top: 5),
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == controller.newPasswordController.value) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      isObscureText: true),
                  CustomButton(
                    height: getVerticalSize(39),
                    text: "lbl_save".tr,
                    margin: getMargin(left: 26, top: 28, right: 26, bottom: 5),
                    alignment: Alignment.center,
                    onTap: () => onTapSave(context),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  onTapArrowleft4() {
    Get.back();
  }

  void onTapSave(context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      await controller.changePassword();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(controller.snackBar);
    }
  }
}
