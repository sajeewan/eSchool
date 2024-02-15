import '../controller/admin_students_list_controller.dart';
import '../models/listrectangleone5_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Listrectangleone5ItemWidget extends StatelessWidget {
  Listrectangleone5ItemWidget(this.listrectangleone5ItemModelObj);

  Listrectangleone5ItemModel listrectangleone5ItemModelObj;

  var controller = Get.find<AdminStudentsListController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        all: 10,
      ),
      decoration: AppDecoration.outlineBlack9003f1,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle1,
            height: getSize(
              40,
            ),
            width: getSize(
              40,
            ),
            radius: BorderRadius.circular(
              getHorizontalSize(
                14,
              ),
            ),
            margin: getMargin(
              bottom: 4,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 14,
              top: 1,
              bottom: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "lbl_student_name".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtRobotoRegular16Black900dd.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.15,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 4,
                  ),
                  child: Text(
                    "lbl_class".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtRobotoRegular14.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
