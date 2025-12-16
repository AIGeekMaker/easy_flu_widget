import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double get screenWidth => ScreenUtil().screenWidth;

double get screenHeight => ScreenUtil().screenHeight;

double get statusBarHeight => ScreenUtil().statusBarHeight;

double get bottomBarHeight => ScreenUtil().bottomBarHeight;

bool useOriginSize = false;

///-------------------------------------------------------间距---------------------------------------------------
EdgeInsetsGeometry getEdgeInsetsAll(double value) {
  return EdgeInsetsDirectional.symmetric(
      vertical: getHeight(value), horizontal: getHeight(value));
}

EdgeInsetsGeometry getEdgeInsetsSymmetric(
    {double vertical = 0, double horizontal = 0}) {
  return EdgeInsetsDirectional.symmetric(
      vertical: getHeight(vertical), horizontal: getHeight(horizontal));
}

EdgeInsetsGeometry getEdgeInsetsOnly(
    {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
  return EdgeInsetsDirectional.only(
      start: getHeight(left),
      end: getHeight(right),
      top: getHeight(top),
      bottom: getHeight(bottom));
}

EdgeInsetsGeometry getSafeBottomEdgeInsets(
    {required BuildContext context, double bottom = 20}) {
  return getEdgeInsetsOnly(
      bottom: MediaQuery.of(context).viewPadding.bottom > 0
          ? MediaQuery.of(context).viewPadding.bottom
          : bottom);
}

///------------------------------------------------------宽,高,字体----------------------------------------------------
double getSp(double sp) {
  if (useOriginSize) {
    return sp;
  }
  try {
    return sp.sp;
  } catch (e) {
    return sp;
  }
}

double getHeight(double height) {
  if (useOriginSize) {
    return height;
  }
  try {
    return height.h;
  } catch (e) {
    return height;
  }
}

double getWidth(double width) {
  if (useOriginSize) {
    return width;
  }
  try {
    return width.w;
  } catch (e) {
    return width;
  }
}

double getRadius(double radius) {
  if (useOriginSize) {
    return radius;
  }
  try {
    return radius.r;
  } catch (e) {
    return radius;
  }
}
