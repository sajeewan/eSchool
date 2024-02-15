import 'controller/announcements_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:eschool/widgets/custom_button.dart';
import 'package:eschool/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AnnouncementsScreen extends GetWidget<AnnouncementsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
            height: getVerticalSize(98),
            leadingWidth: 50,
            leading: AppbarImage(
                height: getVerticalSize(17),
                width: getHorizontalSize(30),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 20, top: 54, bottom: 27),
                onTap: onTapArrowleft1),
            centerTitle: true,
            title: AppbarTitle(
              text: "lbl_announcements".tr,
              margin: getMargin(top: 54, bottom: 20),
            ),
            styleType: Style.bgFillBluegray700),
        body: Container(
          width: double.maxFinite,
          padding: getPadding(left: 48, top: 133, right: 48),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("lbl_title".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsMedium14),
                CustomTextFormField(
                  focusNode: FocusNode(),
                  controller: controller.titleController,
                  hintText: "lbl_title".tr,
                  margin: getMargin(top: 2),
                ),
                Padding(
                  padding: getPadding(top: 29),
                  child: Text("lbl_message".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium14),
                ),
                CustomTextFormField(
                  focusNode: FocusNode(),
                  controller: controller.messageController,
                  hintText: "lbl_message".tr,
                  margin: getMargin(top: 3),
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                ),
                CustomButton(
                    height: getVerticalSize(39),
                    text: "lbl_send".tr,
                    margin: getMargin(left: 26, top: 28, right: 26, bottom: 5),
                    alignment: Alignment.center,
                    onTap: () => onTapSubmit(context)),
              ]),
        ),
      ),
    );
  }

  onTapArrowleft1() {
    Get.back();
  }

  onTapSubmit(context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    controller.createAnnouncement();
  }
}
