import '../controller/role_controller.dart';
import '../models/role_screen_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoleScreenItemWidget extends StatelessWidget {
  RoleScreenItemWidget(this.roleScreenItemModelObj, {this.onTapAdminbtn});

  RoleScreenItemModel roleScreenItemModelObj;

  var controller = Get.find<RoleController>();

  VoidCallback? onTapAdminbtn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAdminbtn!();
      },
      child: Container(
        padding: getPadding(
          all: 32,
        ),
        decoration: AppDecoration.outlineBlack9003f2.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder14,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgAdministratormale,
              height: getSize(
                96,
              ),
              width: getSize(
                96,
              ),
              margin: getMargin(
                top: 4,
              ),
            ),
            Obx(
              () => Text(
                roleScreenItemModelObj.adminTxt.value,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtRalewaySemiBold15Gray900.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
