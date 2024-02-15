import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.shape,
      this.enabled,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.validator});

  TextFormFieldShape? shape;

  bool? enabled;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.RalewaySemiBold14:
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
      case TextFormFieldFontStyle.RalewaySemiBold14Gray900:
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
      case TextFormFieldFontStyle.RalewayMedium15:
        return TextStyle(
          color: ColorConstant.blueGray40099,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.20,
          ),
        );
      case TextFormFieldFontStyle.RalewayBold15:
        return TextStyle(
          color: ColorConstant.blueGray40099,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w700,
          height: getVerticalSize(
            1.20,
          ),
        );
      default:
        return TextStyle(
          color: ColorConstant.blueGray400,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: getVerticalSize(
            1.50,
          ),
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlineBlack90019:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.black90019,
            width: 1,
          ),
        );
      case TextFormFieldVariant.OutlineBlack90019_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.black90019,
            width: 1,
          ),
        );
      case TextFormFieldVariant.FillGray100:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.gray500,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.OutlineBlack90019:
        return ColorConstant.blueGray700;
      case TextFormFieldVariant.OutlineBlack90019_1:
        return ColorConstant.whiteA700;
      case TextFormFieldVariant.FillGray100:
        return ColorConstant.gray100;
      default:
        return null;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray500:
        return false;
      case TextFormFieldVariant.OutlineBlack90019:
        return true;
      case TextFormFieldVariant.OutlineBlack90019_1:
        return true;
      case TextFormFieldVariant.FillGray100:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return false;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT71:
        return getPadding(
          left: 10,
          top: 71,
          right: 10,
          bottom: 71,
        );
      case TextFormFieldPadding.PaddingT13:
        return getPadding(
          top: 13,
          right: 13,
          bottom: 13,
        );
      case TextFormFieldPadding.PaddingT13_1:
        return getPadding(
          top: 13,
          bottom: 13,
        );
      default:
        return getPadding(
          all: 11,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder8,
  RoundedBorder5,
}

enum TextFormFieldPadding {
  PaddingAll11,
  PaddingT71,
  PaddingT13,
  PaddingT13_1,
}

enum TextFormFieldVariant {
  None,
  OutlineGray500,
  OutlineBlack90019,
  OutlineBlack90019_1,
  FillGray100,
}

enum TextFormFieldFontStyle {
  PoppinsRegular12,
  RalewaySemiBold14,
  RalewaySemiBold14Gray900,
  RalewayMedium15,
  RalewayBold15,
}
