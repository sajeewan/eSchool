import 'package:flutter/material.dart';
import 'package:eschool/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get fillBluegray700 => BoxDecoration(
        color: ColorConstant.blueGray700,
      );
  static BoxDecoration get outlineBlack9003f => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              4,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: ColorConstant.blue50,
      );
  static BoxDecoration get outlineBlack9003f1 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9003f2 => BoxDecoration(
        color: ColorConstant.whiteA700,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get txtFillBluegray700 => BoxDecoration(
        color: ColorConstant.blueGray700,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder14 = BorderRadius.circular(
    getHorizontalSize(
      14,
    ),
  );

  static BorderRadius customBorderBL40 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        40,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        40,
      ),
    ),
  );

  static BorderRadius txtRoundedBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10,
    ),
  );

  static BorderRadius roundedBorder20 = BorderRadius.circular(
    getHorizontalSize(
      20,
    ),
  );

  static BorderRadius circleBorder50 = BorderRadius.circular(
    getHorizontalSize(
      50,
    ),
  );
}
