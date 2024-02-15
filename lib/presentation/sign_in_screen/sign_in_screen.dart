import 'controller/sign_in_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/core/utils/validation_functions.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

// ignore_for_file: must_be_immutable
class SignInScreen extends GetWidget<SignInController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.whiteA700,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  width: double.maxFinite,
                  child: Container(
                      padding: getPadding(top: 0, bottom: 90),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: fs.Svg(ImageConstant.imgTopvector),
                              fit: BoxFit.cover)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomAppBar(
                                height: getVerticalSize(118),
                                leadingWidth: 44,
                                leading: AppbarImage(
                                    height: getVerticalSize(36),
                                    width: getHorizontalSize(24),
                                    svgPath:
                                        ImageConstant.imgArrowleftWhiteA700,
                                    margin: getMargin(left: 20),
                                    onTap: onTapArrowleft3),
                                title: Padding(
                                    padding: getPadding(left: 5),
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              getPadding(top: 0, bottom: 0),
                                          child: GestureDetector(
                                            onTap: onTapArrowleft3,
                                            child: Text("lbl_back".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style:
                                                    AppStyle.txtInterMedium16),
                                          )),
                                      AppbarTitle(
                                          text: "lbl_sign_in".tr,
                                          margin: getMargin(left: 88))
                                    ])))
                          ]))),
              Padding(
                  padding: getPadding(top: 38),
                  child: Text("msg_sign_in_to_continue".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRalewayRomanBold20
                          .copyWith(letterSpacing: getHorizontalSize(0.6)))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: getPadding(left: 42, top: 78),
                      child: Text("lbl_email".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtRalewaySemiBold15Gray90099
                              .copyWith(
                                  letterSpacing: getHorizontalSize(0.45))))),
              CustomTextFormField(
                  focusNode: FocusNode(),
                  controller: controller.emailvalueController,
                  hintText: "msg_demo_mail_gmail_com".tr,
                  margin: getMargin(left: 42, top: 4, right: 42),
                  variant: TextFormFieldVariant.FillGray100,
                  padding: TextFormFieldPadding.PaddingT13,
                  fontStyle: TextFormFieldFontStyle.RalewayMedium15,
                  textInputType: TextInputType.emailAddress,
                  prefix: Container(
                      margin:
                          getMargin(left: 14, top: 13, right: 10, bottom: 13),
                      decoration:
                          BoxDecoration(color: ColorConstant.blueGray40099),
                      child: CustomImageView(svgPath: ImageConstant.imgMail)),
                  prefixConstraints:
                      BoxConstraints(maxHeight: getVerticalSize(45)),
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
                  padding: getPadding(left: 42, top: 5),
                  child: Text(
                    "lbl_password".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRalewaySemiBold15Gray90099.copyWith(
                      letterSpacing: getHorizontalSize(0.45),
                    ),
                  ),
                ),
              ),
              Obx(
                () => CustomTextFormField(
                    // focusNode: FocusNode(),
                    isObscureText: controller.isNotVisible.value,
                    controller: controller.passwordvalueController,
                    hintText: "lbl".tr,
                    margin: getMargin(left: 42, top: 2, right: 42),
                    variant: TextFormFieldVariant.FillGray100,
                    padding: TextFormFieldPadding.PaddingT13_1,
                    fontStyle: TextFormFieldFontStyle.RalewayBold15,
                    textInputAction: TextInputAction.done,
                    prefix: Container(
                        margin:
                            getMargin(left: 14, top: 14, right: 16, bottom: 14),
                        decoration:
                            BoxDecoration(color: ColorConstant.blueGray40099),
                        child: CustomImageView(svgPath: ImageConstant.imgLock)),
                    prefixConstraints:
                        BoxConstraints(maxHeight: getVerticalSize(45)),
                    suffix: Container(
                      margin:
                          getMargin(left: 30, top: 17, right: 25, bottom: 13),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(controller.isNotVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        onTap: () => controller.isNotVisible.value =
                            !controller.isNotVisible.value,
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: getVerticalSize(45),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the password";
                      }
                      return null;
                    }),
              ),
              CustomButton(
                height: getVerticalSize(45),
                text: "lbl_sign_in".tr,
                margin: getMargin(left: 42, top: 50, right: 42),
                fontStyle: ButtonFontStyle.RalewayBold20,
                onTap: () => onTapSignin(context),
              ),
              Spacer(),
              CustomImageView(
                svgPath: ImageConstant.imgBottomvector,
                height: getVerticalSize(209),
                width: getHorizontalSize(414),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  onTapArrowleft3() {
    Get.back();
  }

  onTapSignin(context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState!.validate()) {
      await signInController.signInUsingEmailPassword();
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(controller.snackBar);
  }
}
