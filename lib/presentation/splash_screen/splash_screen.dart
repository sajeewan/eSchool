import 'package:fluttertoast/fluttertoast.dart';

import 'controller/splash_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(left: 21, right: 21),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
                imagePath: ImageConstant.imgAppstorelogo4,
                height: getVerticalSize(307),
                width: getHorizontalSize(372)),
            Text(
              "lbl_eschool".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtRalewayBold37.copyWith(
                letterSpacing: getHorizontalSize(0.74),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
