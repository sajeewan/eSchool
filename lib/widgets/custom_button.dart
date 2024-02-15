import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(
          all: 8,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillRedA200:
        return ColorConstant.redA200;
      case ButtonVariant.OutlineBlack90019:
        return ColorConstant.whiteA700;
      case ButtonVariant.OutlineBlack90019_1:
        return ColorConstant.blueGray700;
      default:
        return ColorConstant.blueGray700;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineBlack90019:
        return BorderSide(
          color: ColorConstant.black90019,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlack90019_1:
        return BorderSide(
          color: ColorConstant.black90019,
          width: getHorizontalSize(
            1.00,
          ),
        );
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.RalewaySemiBold14:
        return TextStyle(
          color: ColorConstant.gray900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.21,
          ),
        );
      case ButtonFontStyle.RalewaySemiBold14WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
          height: getVerticalSize(
            1.21,
          ),
        );
      case ButtonFontStyle.RalewayBold20:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.20,
          ),
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.53,
          ),
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder10,
  RoundedBorder5,
}

enum ButtonPadding {
  PaddingAll8,
}

enum ButtonVariant {
  FillBluegray700,
  FillRedA200,
  OutlineBlack90019,
  OutlineBlack90019_1,
}

enum ButtonFontStyle {
  PoppinsBold15,
  RalewaySemiBold14,
  RalewaySemiBold14WhiteA700,
  RalewayBold20,
}
