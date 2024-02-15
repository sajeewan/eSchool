import '../role_screen/widgets/role_screen_item_widget.dart';
import 'controller/role_controller.dart';
import 'models/role_screen_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class RoleScreen extends GetWidget<RoleController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: ImageConstant.imgTopvector,
                          height: getVerticalSize(209),
                          width: getHorizontalSize(414)),
                      Padding(
                          padding: getPadding(top: 42),
                          child: Text("msg_select_a_role_to".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtRalewayRomanBold20.copyWith(
                                  letterSpacing: getHorizontalSize(0.6)))),
                      Padding(
                        padding: getPadding(top: 20, right: 45, left: 45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signInScreen);
                                  },
                                  child: Container(
                                    padding: getPadding(
                                      all: 32,
                                    ),
                                    decoration: AppDecoration.outlineBlack9003f
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder14,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant
                                              .imgAdministratormale,
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
                                        Text(
                                          "Admin",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRalewaySemiBold15Gray900
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signInScreen);
                                  },
                                  child: Container(
                                    padding: getPadding(
                                      all: 32,
                                    ),
                                    decoration: AppDecoration.outlineBlack9003f
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder14,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgManager,
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
                                        Text(
                                          "Teacher",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRalewaySemiBold15Gray900
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(top: 18, right: 45, left: 45),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signInScreen);
                                  },
                                  child: Container(
                                    padding: getPadding(
                                      all: 32,
                                    ),
                                    decoration: AppDecoration.outlineBlack9003f
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder14,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath:
                                              ImageConstant.imgStudentmale,
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
                                        Text(
                                          "Student",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRalewaySemiBold15Gray900
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.signInScreen);
                                  },
                                  child: Container(
                                    padding: getPadding(
                                      all: 32,
                                    ),
                                    decoration: AppDecoration.outlineBlack9003f
                                        .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder14,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          imagePath:
                                              ImageConstant.imgCollaboratormale,
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
                                        Text(
                                          "Emoloyee",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtRalewaySemiBold15Gray900
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      CustomImageView(
                          svgPath: ImageConstant.imgBottomvector,
                          height: getVerticalSize(209),
                          width: getHorizontalSize(414),
                          margin: getMargin(top: 0))
                    ]))));
  }

  onTapAdminbtn() {
    Get.toNamed(AppRoutes.signInScreen);
  }
}
